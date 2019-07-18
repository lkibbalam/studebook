# frozen_string_literal: true

module Commentable
  extend ActiveSupport::Concern

  def comments
    @comments = commentable.comments
    respond_with(@comments)
  end

  def create_comment
    @comment = commentable.comments.new(comment_params.merge(user: current_user))
    @comment.parent_id = @commentable.id if @commentable.class.name == "Comment"
    render json: @comment if @comment.save
  end

  def update_comment
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
    render json: @comment
  end

  def destroy_comment
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_with(@comment)
  end

  private
    def commentable
      controller_path.classify.tr("Api::V1::", "").constantize.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body)
    end
end
