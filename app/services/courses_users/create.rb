# frozen_string_literal: true

require 'rails_helper'

module CoursesUsers
  class Create
    include Callable

    def initialize(course:, user:)
      @course = course
      @user = user
    end

    def call
      create_course_user &&
        create_lessons_user &&
        create_tasks_user
    end

    private

    attr_reader :course, :user

    def create_course_user
      CoursesUser.create!(course: course, student: user)
    end

    def create_lessons_user
      LessonsUser.create!(lessons: course.lessons, student: user)
    end
     TODO #Finish this shit
    def create_tasks_user
      tasks = []
      course.lessons.each { |lesson| tasks << lesson.tasks }
      TasksUser.create!(tasks: tasks, user: user)
    end
  end
end
