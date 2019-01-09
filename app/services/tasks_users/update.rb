# frozen_string_literal: true

module TasksUsers
  class Update
    include Callable

    def initialize(task_user:, current_user:, params:)
      @task_user = task_user
      @current_user = current_user
      params.each { |key, value| instance_variable_set("@#{key}", value) }
    end

    def call
      ActiveRecord::Base.transaction do
        update_task_user
        create_notification
        create_comment
        unlock_next_lesson! if all_lesson_tasks_user_accept?
        task_user
      end
    end

    private

    attr_reader :task_user, :current_user, :status, :github_url, :comment

    def update_task_user
      task_user.update!(task_user_attributes)
    end

    def create_notification
      Notification.create!(notification_attributes)
    end

    def create_comment
      Comment.create!(comment_attributes)
    end

    def all_lesson_tasks_user_accept?
      TasksUser.where(user: task_user.user, task: task_user.task.lesson.tasks).all?(&:accept?)
    end

    def unlock_next_lesson!
      course_lessons = task_user.task.lesson.course.lessons.sort
      lesson_index = course_lessons.index(task_user.task.lesson)

      lesson_done!(course_lessons[lesson_index])

      next_lesson = course_lessons[lesson_index + 1]
      lesson_user = task_user.user.lessons_users.find_by(lesson: next_lesson)
      lesson_user.update!(status: :unlocked) if lesson_user&.locked?
    end

    def lesson_done!(lesson)
      lesson_user = task_user.user.lessons_users.find_by(lesson: lesson)
      lesson_user.update!(status: :done) if lesson_user&.unlocked?
      change_course_progress
    end

    def change_course_progress
      course = task_user.task.lesson.course
      course_user = task_user.user.courses_users.find_by(course: course)
      course_user.update(progress: course_user.progress + course.lesson_value)
    end

    def notification_attributes
      {
        verifying: { user: task_user.user.mentor, tasks_user: task_user },
        change: { user: task_user.user, tasks_user: task_user },
        accept: { user: task_user.user, tasks_user: task_user }
      }[status.to_sym]
    end

    def task_user_attributes
      {
        status: status,
        github_url: github_url
      }.compact
    end

    def comment_attributes
      {
        body: comment,
        user: current_user,
        commentable: task_user
      }.compact
    end
  end
end
