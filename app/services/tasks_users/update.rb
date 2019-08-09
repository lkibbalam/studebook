# frozen_string_literal: true

module TasksUsers
  class Update
    include Callable
    delegate :user, :mentors, :course, :task, to: :task_user
    delegate :lesson, :lesson_accepted_for?, to: :task

    def initialize(task_user:, current_user:, params:)
      @task_user = task_user
      @current_user = current_user
      @params = params
    end

    def call
      ActiveRecord::Base.transaction do
        update_task_user
        create_notifications
        create_comment
        unlock_next_lesson! if lesson_accepted_for?(user)
        task_user
      end
    end

    private
      attr_reader :task_user, :current_user, :params

      def update_task_user
        task_user.update!(task_user_attributes)
      end

      def create_notifications
        receivers[params[:status]].each do |receiver|
          task_user.notifications.create!(user: receiver)
          send_email(receiver)
        end
      end

      def send_email(receiver)
        return unless receivers.key?(params[:status])
        NotificationMailer.send_user_task_notification(receiver: receiver, task_user: task_user)
      end

      def create_comment
        Comment.create!(comment_attributes)
        end

      def unlock_next_lesson!
        user.done_lesson(lesson)
        next_lesson = course.next_lesson(lesson)
        return unless next_lesson
        next_user_lesson = user.lessons_users.find_by(lesson: next_lesson)
        next_user_lesson.unlock! if next_user_lesson.locked?
      end

      def receivers
        {
          verifying: mentors,
          change: [user],
          accept: [user]
        }.with_indifferent_access
      end

      def task_user_attributes
        {
          status: params[:status],
          github_url: params[:github_url]
        }.compact
      end

      def comment_attributes
        {
          body: params[:comment],
          user: current_user,
          commentable: task_user
        }.compact
      end
  end
end
