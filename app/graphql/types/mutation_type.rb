# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :sign_in_user, mutation: Mutations::SignInUser, null: true

    field :create_user, mutation: Mutations::CreateUser, null: false do
      guard ->(user, _args, ctx) { UserPolicy.new(ctx[:me], user.object).create? }
    end
    field :update_user, mutation: Mutations::UpdateUser, null: false do
      guard ->(user, _args, ctx) { UserPolicy.new(ctx[:me], user.object).update? }
    end
    field :destroy_user, mutation: Mutations::DestroyUser, null: false do
      guard ->(user, _args, ctx) { UserPolicy.new(ctx[:me], user.object).destroy? }
    end

    field :create_team, mutation: Mutations::CreateTeam, null: false do
      guard ->(team, _args, ctx) { TeamPolicy.new(ctx[:me], team.object).create? }
    end
    field :update_team, mutation: Mutations::UpdateTeam, null: false do
      guard ->(team, _args, ctx) { TeamPolicy.new(ctx[:me], team.object).update? }
    end
    field :destroy_team, mutation: Mutations::DestroyTeam, null: false do
      guard ->(team, _args, ctx) { TeamPolicy.new(ctx[:me], team.object).destroy? }
    end

    field :create_course, mutation: Mutations::CreateCourse, null: false do
      guard ->(course, _args, ctx) { CoursePolicy.new(ctx[:me], course.object).create? }
    end
    field :update_course, mutation: Mutations::UpdateCourse, null: false do
      guard ->(course, _args, ctx) { CoursePolicy.new(ctx[:me], course.object).update? }
    end
    field :destroy_course, mutation: Mutations::DestroyCourse, null: false do
      guard ->(course, _args, ctx) { CoursePolicy.new(ctx[:me], course.object).destroy? }
    end

    field :create_lesson, mutation: Mutations::CreateLesson, null: false do
      guard ->(lesson, _args, ctx) { LessonPolicy.new(ctx[:me], lesson.object).create? }
    end
    field :update_lesson, mutation: Mutations::UpdateLesson, null: false do
      guard ->(lesson, _args, ctx) { LessonPolicy.new(ctx[:me], lesson.object).update? }
    end
    field :destroy_lesson, mutation: Mutations::DestroyLesson, null: false do
      guard ->(lesson, _args, ctx) { LessonPolicy.new(ctx[:me], lesson.object).destroy? }
    end

    field :create_task, mutation: Mutations::CreateTask, null: false do
      guard ->(task, _args, ctx) { TaskPolicy.new(ctx[:me], task.object).create? }
    end
    field :update_task, mutation: Mutations::UpdateTask, null: false do
      guard ->(task, _args, ctx) { TaskPolicy.new(ctx[:me], task.object).update? }
    end
    field :destroy_task, mutation: Mutations::DestroyTask, null: false do
      guard ->(task, _args, ctx) { TaskPolicy.new(ctx[:me], task.object).destroy? }
    end

    field :start_course, mutation: Mutations::StartCourse, null: false do
      guard ->(course_user, _args, ctx) { CoursesUserPolicy.new(ctx[:me], course_user.object).create? }
    end
    field :update_lesson_user, mutation: Mutations::UpdateLessonUser, null: false do
      guard ->(lesson_user, _args, ctx) { LessonsUserPolicy.new(ctx[:me], lesson_user.object).update? }
    end
    field :update_task_user, mutation: Mutations::UpdateTaskUser, null: false do
      guard ->(task_user, _args, ctx) { TasksUserPolicy.new(ctx[:me], task_user.object).update? }
    end
  end
end
