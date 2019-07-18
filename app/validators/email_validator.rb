# frozen_string_literal: true

class EmailValidator < ActiveModel::Validator
  def validate(record)
    @record = record
    send(record.class.name.downcase)
  end

  private
    attr_reader :record

    def user
      return if email_empty?(record.email)

      email_incorrect?(record.email)
    end

    def email_empty?(email)
      record.errors[:email] << "empty" if email.blank?
    end

    def email_incorrect?(email)
      email_regexp = URI::MailTo::EMAIL_REGEXP
      record.errors[:email] << "invalid" unless email_regexp.match?(email)
    end
end
