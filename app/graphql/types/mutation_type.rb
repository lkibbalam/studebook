# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :sign_in_user, mutation: Mutations::SignInUser, null: true
    field :create_user, mutation: Mutations::CreateUser, null: false
    field :update_user, mutation: Mutations::UpdateUser, null: false
    field :destroy_user, mutation: Mutations::DestroyUser, null: false

    field :create_team, mutation: Mutations::CreateTeam, null: false
    field :update_team, mutation: Mutations::UpdateTeam, null: false
    field :destroy_team, mutation: Mutations::DestroyTeam, null: false

    field :create_course, mutation: Mutations::CreateCourse, null: false
    field :update_course, mutation: Mutations::UpdateCourse, null: false
    field :destroy_course, mutation: Mutations::DestroyCourse, null: false

    field :start_course, mutation: Mutations::StartCourse, null: false
    field :update_lesson_user, mutation: Mutations::UpdateLessonUser, null: false
    field :update_task_user, mutation: Mutations::UpdateTaskUser, null: false
    field :update_task_user, mutation: Mutations::UpdateTaskUser, null: false
  end
end
