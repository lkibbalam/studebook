# frozen_string_literal: true

module LessonsUsers
  class Update
    include Callable

    def initialize(lesson_user:, params:)
      @lesson_user = lesson_user
      @params = params
    end

    def call
      ActiveRecord::Base.transaction do
        update_lesson_user &&
          unlock_next_lesson_user
        lesson_user
      end
    end

    private

    attr_reader :lesson_user, :params

    def update_lesson_user
      lesson_user.update!(params)
    end

    def unlock_next_lesson_user
      return unless lesson_user.done?

      next_lesson = next_course_lesson
      return course_user_archived! unless next_lesson

      next_lesson_user = LessonsUser.find_by(lesson: next_lesson, student: lesson_user.student)
      next_lesson_user&.unlock!
    end

    def next_course_lesson
      course_lessons = lesson_user.lesson.course.lessons.sort
      lesson_index = course_lessons.index(lesson_user.lesson)
      course_lessons[lesson_index + 1]
    end

    def course_user_archived!
      course = lesson_user.lesson.course
      course_user = CoursesUser.find_by(course: course, student: lesson_user.student)
      course_user.archived! && full_progress!(course_user)
    end

    def full_progress!(course_user)
      course_user.update(progress: 100)
    end
  end
end
