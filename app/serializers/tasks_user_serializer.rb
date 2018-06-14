# frozen_string_literal: true

class TasksUserSerializer < ActiveModel::Serializer
  attributes %i[task_id user_id github_url mark status created_at updated_at task lesson course]

  def task
    object.task
  end

  def lesson
    task.lesson
  end

  def course
    lesson.course
  end
end
