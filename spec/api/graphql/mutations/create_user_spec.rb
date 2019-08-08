# frozen_string_literal: true

require "rails_helper"

module Mutations
  describe CreateUser, type: :request do
    let(:admin) { create(:user, :admin) }
    let(:email) { Faker::Internet.email }
    describe ".resolve" do
      it "creates a user" do
        admin
        expect do
          post "/graphql",
               params: { query: query(email: Faker::Internet.email, password: "123456", role: ) },
               headers: authenticated_header(admin)
        end.to change { User.count }.by(1)
      end

      it "returns a user" do
        post "/graphql",
             params: { query: query(email: Faker::Internet.email, password: "123456") },
             headers: authenticated_header(admin)
        json = JSON.parse(response.body)
        puts json
        data = json["data"]["createUser"]["user"]

        expect(data).to include("email" => email,
                                "id" => User.last.id.to_s)
      end

      xit "returns errors" do
        post "/graphql",
             params: { query: query(course_id: course.id, title: "", description: "") },
             headers: authenticated_header(admin)
        errors = JSON.parse(response.body).dig("data", "createLesson", "errors")
        expect(errors).to include({ "path" => nil, "message" => "Title can't be blank" },
                                  { "path" => nil, "message" => "Title is too short (minimum is 1 character)" },
                                  { "path" => nil, "message" => "Description can't be blank" },
                                  { "path" => nil, "message" => "Description is too short (minimum is 5 characters)" })
      end

      xit "returns non-authenticated error" do
        post "/graphql",
             params: { query: query(course_id: course.id, title: "", description: "") }
        errors = JSON.parse(response.body).dig("errors")[0]
        expect(errors).to include("message" => "Not authorized to access Mutation.createLesson",
                                   "path" => ["createLesson"])
      end
    end

    def query(email:, password:, first_name: nil, last_name: nil, nickname: nil, role: nil, phone: nil, github_url: nil, status: nil)
      <<~GQL
          mutation {
            createUser(
              input: {
                email: "#{email}"
                password: "#{password}"
                firstName: "#{first_name}"
                lastName: "#{last_name}"
                nickname: "#{nickname}"
                role: "#{role}"
                phone: "#{phone}"
                githubUrl: "#{github_url}"
                status: "#{status}"
              }
            )
            {
              user {
                id
                email
                avatar
                firstName 
                lastName 
                nickname 
                role 
                phone 
                githubUrl 
                status 
                createdAt 
                updatedAt
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
