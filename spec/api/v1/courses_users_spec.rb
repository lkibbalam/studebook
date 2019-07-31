# frozen_string_literal: true

require "rails_helper"

describe "courses_users_spec" do
  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user, :student) }
  let(:course_with_lessons_with_tasks) do
    create(:course_with_lessons_with_tasks, :published, lessons_count: 3, tasks_count: 3)
  end

  describe "GET #index" do
    context "non-authenticate request" do
      before { get "/api/v1/" }

      it_behaves_like "non authenticate request"
    end

    context "authenticate request" do
      before { get "/api/v1/", headers: authenticated_header(admin) }

      it_behaves_like "authenticate request"
    end
  end

  describe "POST #create" do
    context "when non authenticate request" do
      before { post "/api/v1/courses/#{course_with_lessons_with_tasks.id}/start_course" }

      it_behaves_like "non authenticate request"
    end

    context "when authenticate request" do
      let(:start_course) do
        post "/api/v1/courses/#{course_with_lessons_with_tasks.id}/start_course",
        headers: authenticated_header(user)
      end

      it { expect { start_course }.to change(CoursesUser, :count).by(1) }
    end
  end
end
