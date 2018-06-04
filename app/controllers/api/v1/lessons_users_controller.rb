# frozen_string_literal: true

module Api
  module V1
    class LessonsUsersController < ApplicationController
      include Commentable

      def show
        lesson = Lesson.find(params[:id])
        lesson_user = current_user.lessons_users.find_by(lesson: lesson, status: %i[unlocked done])
        lesson_tasks_user = current_user.tasks_users.where(task: lesson.tasks)
        video = LessonSerializer.new(lesson).serializable_hash
        respond_with(lesson_tasks_user: lesson_tasks_user.as_json,
                     lesson_user: lesson_user.as_json(include: [lesson: { include: [:tasks, :videos, course:
                       { include: :lessons }] }, comments: { include: :user }]), video: video)
        # TODO: refactor this action for faster, simpler!
      end

      def approve_lesson
        @lesson_user = LessonsUser.find(params[:id])
        @lesson_user.assign_attributes(status: :done)
        render json: @lesson_user.as_json(only: :status) if @lesson_user.save
      end
    end
  end
end
