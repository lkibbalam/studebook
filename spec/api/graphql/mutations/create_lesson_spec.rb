# frozen_string_literal: true

require "rails_helper"

module Mutations
  describe CreateLesson, type: :request do
    let(:course) { create(:course) }
    let(:admin) { create(:user, :admin) }
    let(:user) { create(:user) }

    describe ".resolve" do
      it "creates a lesson" do
        expect do
          post "/graphql",
               params: { query: query(course_id: course.id, title: "Lesson title", description: "Lesson description") },
               headers: authenticated_header(admin)
        end.to change { Lesson.count }.by(1)
      end

      it "returns a lesson" do
        post "/graphql",
             params: { query: query(course_id: course.id, title: "Lesson title", description: "Lesson description") },
             headers: authenticated_header(admin)
        json = JSON.parse(response.body)
        data = json["data"]["createLesson"]["lesson"]

        expect(data).to include("description" => "Lesson description",
                                "id" => Lesson.last.id.to_s,
                                "title" => "Lesson title")
      end

      it "returns errors" do
        post "/graphql",
             params: { query: query(course_id: course.id, title: "", description: "") },
             headers: authenticated_header(admin)
        errors = JSON.parse(response.body).dig("data", "createLesson", "errors")
        expect(errors).to include({ "path" => nil, "message" => "Title can't be blank" },
                                  { "path" => nil, "message" => "Title is too short (minimum is 1 character)" },
                                  { "path" => nil, "message" => "Description can't be blank" },
                                  { "path" => nil, "message" => "Description is too short (minimum is 5 characters)" })
      end

      it "returns non-authenticated error" do
        post "/graphql",
             params: { query: query(course_id: course.id, title: "", description: "") },
             headers: authenticated_header(user)
        errors = JSON.parse(response.body).dig("errors")[0]
        expect(errors).to include("message" => "Not authorized to access Mutation.createLesson",
                                   "path" => ["createLesson"])
      end
    end

    def query(course_id:, title:, description:)
      <<~GQL
          mutation {
            createLesson(
              input: {
                courseId: "#{course_id}"
                title: "#{title}"
                description: "#{description}"
              }
            )
            {
              lesson {
                id
                title
                description
              }
              errors {
                path
                message
              }
            }
          }
        GQL
    end
  end
end
