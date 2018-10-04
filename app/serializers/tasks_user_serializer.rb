# frozen_string_literal: true

class TasksUserSerializer < ActiveModel::Serializer
  attributes %i[id task_id user_id github_url mark status created_at updated_at task lesson course comments status]

  def task
    object.task
  end

  def lesson
    task.lesson
  end

  def course
    lesson.course
  end

  def comments
    object.comments.map do |comment|
      CommentSerializer.new(comment)
    end
  end
end
