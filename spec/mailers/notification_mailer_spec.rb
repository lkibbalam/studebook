# frozen_string_literal: true

require "rails_helper"

describe NotificationMailer, type: :mailer do
  describe "notify" do
    let(:mentor) { create(:user, :staff) }
    let(:user) { create(:user, mentors: [mentor]) }
    let(:task_user) { create(:tasks_user) }

    describe ".send_user_task_notification" do
      it "sends verifying email to mentor" do
        task_user.verifying!
        expect_any_instance_of(ActionMailer::Parameterized::Mailer).to(
          receive(:method_missing).with(:verifying_email).and_call_original
        )
        described_class.send_user_task_notification(receiver: mentor, task_user: task_user, github_url: task_user.github_url)
      end

      it "sends change email to student" do
        task_user.change!
        expect_any_instance_of(ActionMailer::Parameterized::Mailer).to(
          receive(:method_missing).with(:change_email).and_call_original
        )
        described_class.send_user_task_notification(receiver: mentor, task_user: task_user, github_url: task_user.github_url)
      end

      it "sends accept email to student" do
        task_user.accept!
        expect_any_instance_of(ActionMailer::Parameterized::Mailer).to(
          receive(:method_missing).with(:accept_email).and_call_original
        )
        described_class.send_user_task_notification(receiver: mentor, task_user: task_user, github_url: task_user.github_url)
      end

      it "does not send email if email is not defined" do
        allow(task_user).to receive(:status).and_return(:undefined_email)
        expect_any_instance_of(ActionMailer::Parameterized::Mailer).not_to(
          receive(:method_missing).with(:undefined_email)
        )
        described_class.send_user_task_notification(receiver: mentor, task_user: task_user, github_url: task_user.github_url)
      end
    end

    describe "#verifying_email" do
      let(:mail) { NotificationMailer.with(receiver: user, task: task_user, github_url: task_user.github_url).verifying_email }

      it "renders the headers" do
        expect(mail.subject)
          .to eq("Your padawan #{task_user.user.first_name} #{task_user.user.last_name} waiting for task approve")
        expect(mail.to).to eq([user.email])
        expect(mail.from).to eq(["no-reply@study.ruby.nixdev.co"])
      end

      it "renders the body" do
        expect(mail.body.encoded).to match("Task review needed")
      end
    end

    describe "#change_email" do
      let(:mail) { NotificationMailer.with(receiver: user, task: task_user, github_url: task_user.github_url).change_email }

      it "renders the headers" do
        expect(mail.subject)
          .to eq("Your are requested for the task changing")
        expect(mail.to).to eq([user.email])
        expect(mail.from).to eq(["no-reply@study.ruby.nixdev.co"])
      end

      it "renders the body" do
        expect(mail.body.encoded).to match("Code changes requested")
      end
    end

    describe "#accept_email" do
      let(:mail) { NotificationMailer.with(receiver: user, task: task_user, github_url: task_user.github_url).accept_email }

      it "renders the headers" do
        expect(mail.subject)
          .to eq("Congratulations! Your task has been approved!")
        expect(mail.to).to eq([user.email])
        expect(mail.from).to eq(["no-reply@study.ruby.nixdev.co"])
      end

      it "renders the body" do
        expect(mail.body.encoded).to match("Your task approved!")
      end
    end
  end
end
