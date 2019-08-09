# frozen_string_literal: true

require "rails_helper"

module Mutations
  describe UpdateTaskUser, type: :request do
    let(:admin) { create(:user, :admin) }
    let(:mentor) { create(:user, :staff) }
    let(:user) { create(:user, mentors: [mentor]) }
    let(:other_user) { create(:user) }
    let(:team_leader_user) { create(:user, role: :leader) }
    let(:team_moder_user) { create(:user, role: :moder) }
    let(:team) { create(:team, users: [user, team_leader_user, team_moder_user]) }
    let(:task_user) { create(:tasks_user, user: user, github_url: nil) }
    let(:github_url) { Faker::Internet.url("github.com") }

    describe ".resolve" do
      context "when status updated" do
        %w[verifying change accept].each do |status|
          it "sets #{status} status and github_url for student" do
            expect do
              post "/graphql",
                   params: { query: query(id: task_user.id, status: status, github_url: github_url) },
                   headers: authenticated_header(user)
            end.to change { task_user.reload.status }.from("undone").to(status)
               .and change { task_user.reload.github_url }.from(nil).to(github_url)
          end

          it "sets #{status} status and github_url for mentor" do
            expect do
              post "/graphql",
                   params: { query: query(id: task_user.id, status: status, github_url: github_url) },
                   headers: authenticated_header(mentor)
            end.to change { task_user.reload.status }.from("undone").to(status)
            .and change { task_user.reload.github_url }.from(nil).to(github_url)
          end

          it "sets #{status} status and github_url for admin" do
            expect do
              post "/graphql",
                   params: { query: query(id: task_user.id, status: status, github_url: github_url) },
                   headers: authenticated_header(admin)
            end.to change { task_user.reload.status }.from("undone").to(status)
            .and change { task_user.reload.github_url }.from(nil).to(github_url)
          end

          it "sets #{status} status and github_url for team leader" do
            task_user.task.lesson.course.update(team: team)
            expect do
              post "/graphql",
                   params: { query: query(id: task_user.id, status: status, github_url: github_url) },
                   headers: authenticated_header(team_leader_user)
            end.to change { task_user.reload.status }.from("undone").to(status)
              .and change { task_user.reload.github_url }.from(nil).to(github_url)
          end

          it "sets #{status} status and github_url for team moder" do
            task_user.task.lesson.course.update(team: team)
            expect do
              post "/graphql",
                   params: { query: query(id: task_user.id, status: status, github_url: github_url) },
                   headers: authenticated_header(team_moder_user)
            end.to change { task_user.reload.status }.from("undone").to(status)
              .and change { task_user.reload.github_url }.from(nil).to(github_url)
          end

          it "returns an updated user task" do
            post "/graphql",
                 params: { query: query(id: task_user.id, status: status, github_url: github_url) },
                 headers: authenticated_header(user)
            data = JSON.parse(response.body).dig("data", "updateTaskUser", "taskUser")

            expect(data).to include("id" => task_user.id.to_s,
                                    "status" => status,
                                    "githubUrl" => github_url)
          end

          it "validates status" do
            post "/graphql",
                 params: { query: query(id: task_user.id, status: "", github_url: "") },
                 headers: authenticated_header(user)
            errors = JSON.parse(response.body).dig("errors")[0]
            expect(errors).to include("path" => ["updateTaskUser"], "message" => "status cannot be blank")
          end

          it "validates github_url" do
            post "/graphql",
                 params: { query: query(id: task_user.id, status: "verifying", github_url: "") },
                 headers: authenticated_header(user)
            errors = JSON.parse(response.body).dig("errors")[0]
            expect(errors).to include("path" => ["updateTaskUser"], "message" => "githubUrl cannot be blank")
          end

          it "returns non-authenticated error" do
            post "/graphql",
                 params: { query: query(id: task_user.id, status: status, github_url: github_url) }
            errors = JSON.parse(response.body).dig("errors")[0]
            expect(errors).to include("message" => "Not authorized to access Mutation.updateTaskUser",
                                      "path" => ["updateTaskUser"])
          end

          it "returns non-authenticated error for other user" do
            post "/graphql",
                 params: { query: query(id: task_user.id, status: status, github_url: github_url) },
                 headers: authenticated_header(other_user)
            errors = JSON.parse(response.body).dig("errors")[0]
            expect(errors).to include("message" => "Not authorized to access Mutation.updateTaskUser",
                                      "path" => ["updateTaskUser"])
          end
        end
      end
    end

    def query(id:, status:, github_url:)
      <<~GQL
          mutation {
            updateTaskUser(
              input: {
                id: "#{id}"
                status: "#{status}"
                githubUrl: "#{github_url}"
              }
            )
            {
              taskUser {
                id
                status
                githubUrl
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
