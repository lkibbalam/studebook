module Commentable
  extend ActiveSupport::Concern

  def comments
    @commentable = set_commentable
    respond_with(@comments = @commentable.comments.as_json(include: :user))
  end

  def create_comment
    @commentable = set_commentable
    @comment = @commentable.comments.new(set_comment_params.merge(user_id: current_user.id))
    @comment.parent_id = @commentable.id if @commentable.class.name == 'Comment'
    render json: @comment.as_json(include: :user) if @comment.save
  end

  def update_comment
    @comment = Comment.find(params[:id])
    @comment.update(set_comment_params)
    render json: @comment.as_json(include: :user)
  end

  def destroy_comment
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_with(@comment)
  end

  private

  def set_commentable
    controller_path.classify.tr('Api::V1::', '').constantize.find(params[:id])
  end

  def set_comment_params
    params.require(:comment).permit(:body)
  end
end
