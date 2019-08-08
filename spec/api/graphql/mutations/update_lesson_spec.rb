# frozen_string_literal: true

require "rails_helper"

module Mutations
  describe UpdateLesson, type: :request do
    let(:lesson) { create(:lesson, title: "Old title") }
    let(:admin) { create(:user, :admin) }
    let(:user) { create(:user) }

    describe ".resolve" do
      it "updates a lesson" do
        expect do
          post "/graphql",
               params: { query: query(id: lesson.id, title: "Lesson title update", position: lesson.position) },
               headers: authenticated_header(admin)
        end.to change { lesson.reload.title }.from("Old title").to("Lesson title update")
      end

      it "updates a lesson position" do
        expect do
          post "/graphql",
               params: { query: query(id: lesson.id, title: lesson.title, position: lesson.position + 1) },
               headers: authenticated_header(admin)
        end.to change { lesson.reload.position }.from(1).to(2)
      end

      it "returns an updated lesson" do
        post "/graphql",
             params: { query: query(id: lesson.id, title: "Updated title", position: lesson.position) },
             headers: authenticated_header(admin)
        json = JSON.parse(response.body)
        data = json["data"]["updateLesson"]["lesson"]

        expect(data).to include("id" => lesson.id.to_s,
                                "title" => "Updated title")
      end

      it "returns errors" do
        post "/graphql",
             params: { query: query(id: lesson.id) },
             headers: authenticated_header(admin)
        errors = JSON.parse(response.body).dig("data", "updateLesson", "errors")
        expect(errors).to include({ "path" => nil, "message" => "Title can't be blank" },
                                  { "path" => nil, "message" => "Title is too short (minimum is 1 character)" },
                                  { "path" => nil, "message" => "Position position cannot be lower than top" })
      end

      it "returns non-authenticated error" do
        post "/graphql",
             params: { query: query(id: lesson.id, title: lesson.title, position: lesson.position) },
             headers: authenticated_header(user)
        errors = JSON.parse(response.body).dig("errors")[0]
        expect(errors).to include("message" => "Not authorized to access Mutation.updateLesson",
                                  "path" => ["updateLesson"])
      end
    end

    def query(id:, title: nil, position: nil)
      <<~GQL
          mutation {
            updateLesson(
              input: {
                id: "#{id}"
                title: "#{title}"
                position: "#{position}"
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
