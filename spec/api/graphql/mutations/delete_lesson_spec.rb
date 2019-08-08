# frozen_string_literal: true

require "rails_helper"

module Mutations
  describe DestroyLesson, type: :request do
    let(:lesson) { create(:lesson) }
    let(:admin) { create(:user, :admin) }
    let(:user) { create(:user) }

    describe ".resolve" do
      it "deletes a lesson" do
        lesson
        expect do
          post "/graphql",
               params: { query: query(id: lesson.id) },
               headers: authenticated_header(admin)
        end.to change { Lesson.count }.by(-1)
      end

      it "returns a message" do
        post "/graphql",
             params: { query: query(id: lesson.id) },
             headers: authenticated_header(admin)
        data = JSON.parse(response.body).dig("data", "destroyLesson", "deleted")

        expect(data).to eq true
      end

      it "returns errors" do
        wrong_id = lesson.id + 100
        post "/graphql",
             params: { query: query(id: wrong_id) },
             headers: authenticated_header(admin)
        errors = JSON.parse(response.body).dig("data", "destroyLesson", "errors")
        expect(errors).to include("message" => "Couldn't find Lesson with 'id'=#{wrong_id}",
                                  "path" => nil)
      end

      it "returns non-authenticated error" do
        post "/graphql",
             params: { query: query(id: lesson.id) },
             headers: authenticated_header(user)
        errors = JSON.parse(response.body).dig("errors")[0]
        expect(errors).to include("message" => "Not authorized to access Mutation.destroyLesson",
                                  "path" => ["destroyLesson"])
      end
    end

    def query(id:)
      <<~GQL
          mutation {
            destroyLesson(
              input: {
                id: "#{id}"
              }
            )
            {
              deleted
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
