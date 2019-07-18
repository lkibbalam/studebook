# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: "studybook.ml"

  def welcome
    @user_params = params[:user_params]
    mail(to: @user_params[:email], subject: "Welcome to StudyBook")
  end
end
