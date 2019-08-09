# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  default from: "no-reply@study.ruby.nixdev.co"
  before_action :set_instance_variables

  def self.send_user_task_notification(receiver:, task_user:, github_url:)
    return unless self.new.respond_to?("#{task_user.status}_email")
    with(receiver: receiver, task: task_user, github_url: github_url)
      .public_send("#{task_user.status}_email")
      .deliver_later
  end

  def verifying_email
    mail(
      to: @receiver.email,
      subject: "Your padawan #{@user.full_name} waiting for task approve"
    )
  end

  def change_email
    mail(
      to: @receiver.email,
      subject: "Your are requested for the task changing"
    )
  end

  def accept_email
    mail(
      to: @receiver.email,
      subject: "Congratulations! Your task has been approved!"
    )
  end

  private
    def set_instance_variables
      @receiver = params[:receiver]
      @github_url = params[:github_url]
      @user = UserDecorator.new(params[:task].user)
    end
end
