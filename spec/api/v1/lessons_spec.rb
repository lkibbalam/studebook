# frozen_string_literal: true

require "rails_helper"

describe "lessons_controller_spec" do
  let!(:user) { create(:user) }
  let!(:admin) { create(:user, :admin) }
  let(:course_with_lessons_with_tasks) do
    create(:course_with_lessons_with_tasks, :published, lessons_count: 10, tasks_count: 3)
  end
  let(:first_lesson) { course_with_lessons_with_tasks.lessons.first }
  let!(:lessons_user) do
    create(:lessons_user, student: user, lesson: first_lesson)
  end

  describe "GET #index" do
    let(:lessons) { create_list(:lesson, 10, course: course) }
    context "when non-authenticate" do
      before { get "/api/v1/courses/#{course_with_lessons_with_tasks.id}/lessons" }

      it_behaves_like "non authenticate request"
    end

    context "when authenticate" do
      before { get "/api/v1/courses/#{course_with_lessons_with_tasks.id}/lessons", headers: authenticated_header(admin) }

      it_behaves_like "authenticate request"
      it_behaves_like "response body with 10 objects"
    end
  end

  describe "GET #show" do
    context "when non-authenticate" do
      before { get "/api/v1/lessons/#{first_lesson.id}" }

      it_behaves_like "non authenticate request"
    end

    context "when authenticate" do
      before { get "/api/v1/lessons/#{first_lesson.id}", headers: authenticated_header(admin) }

      it_behaves_like "authenticate request"

      %w[course_id description material title].each do |attribute|
        it "user object contains #{attribute}" do
          expect(response.body)
            .to be_json_eql(first_lesson.send(attribute.to_sym).to_json)
            .at_path("data/attributes/#{attribute.camelize(:lower)}")
        end
      end
    end
  end

  describe "POST #create" do
    context "when non-authenticate" do
      before { post "/api/v1/courses/#{course_with_lessons_with_tasks.id}/lessons", params: { lesson: attributes_for(:lesson) } }

      it_behaves_like "non authenticate request"
    end
    context "when authenticate" do
      let(:create_lesson) do
        post "/api/v1/courses/#{course_with_lessons_with_tasks.id}/lessons", params: { lesson: attributes_for(:lesson) },
                                                     headers: authenticated_header(admin)
      end

      it "when lesson with valid params" do
        expect { create_lesson }.to change(Lesson, :count).by(1)
      end
    end
  end

  describe "PATCH #update" do
    context "when non-authenticate" do
      before do
        patch "/api/v1/lessons/#{first_lesson.id}", params: { lesson: { task: "NewTask", material: "NewMaterial",
                                                                         description: "NewDesc" } }
      end

      it_behaves_like "non authenticate request"
    end

    context "when authenticate" do
      before do
        patch "/api/v1/lessons/#{first_lesson.id}", params: { lesson: { task: "NewTask", material: "NewMaterial",
                                                                         description: "NewDesc" } },
                                                     headers: authenticated_header(admin)
        first_lesson.reload
      end

      it { expect(first_lesson.description).to eql("NewDesc") }
      it { expect(first_lesson.material).to eql("NewMaterial") }
    end
  end

  describe "DELETE #delete" do
    context "when non-authenticate" do
      before { delete "/api/v1/lessons/#{first_lesson.id}" }

      it_behaves_like "non authenticate request"
    end

    context "when authenticate" do
      let(:delete_lesson) { delete "/api/v1/lessons/#{first_lesson.id}", headers: authenticated_header(admin) }
      it { expect { delete_lesson }.to change(Lesson, :count).by(-1) }
    end
  end

  describe "Nested comments" do
    let!(:subject) { create(:lesson) }

    describe "GET #comments" do
      it_behaves_like "Commentable_comment"
    end

    describe "POST #create_comment" do
      it_behaves_like "Commentable_create"
    end

    describe "PATCH #update_comment" do
      it_behaves_like "Commentable_update"
    end

    describe "DELETE #destroy_comment" do
      it_behaves_like "Commentable_destroy"
    end
  end
end
