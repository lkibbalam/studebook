# frozen_string_literal: true

module CoursesUsers
  class Create
    include Callable

    def initialize(course:, user:)
      @course = course
      @user = user
    end

    def call
      ActiveRecord::Base.transaction do
        create_lessons_user &&
          create_tasks_user &&
          create_course_user
      end
    end

    private
      attr_reader :course, :user

      def create_course_user
        CoursesUser.create!(course: course, student: user)
      end

      def create_lessons_user
        lessons_user = course.lessons.ids.sort.map { |id| { lesson_id: id, student_id: user.id } }
        unlock_first_lesson!(lessons_user)
        LessonsUser.create!(lessons_user)
      end

      def create_tasks_user
        tasks_user = []
        course.lessons.includes(:tasks).each do |lesson|
          tasks_user << lesson.tasks.ids.map { |id| { user_id: user.id, task_id: id } }
        end
        TasksUser.create!(tasks_user)
      end

      def unlock_first_lesson!(lessons_user)
        lessons_user.first[:status] = :unlocked
      end
  end
end
