module Commentable
  extend ActiveSupport::Concern

  def comments
    @commentable = set_commentable
    respond_with(@comments = @commentable.comments.order(created_at: :desc))
  end

  def create_comment
    @commentable = set_commentable
    @comment = @commentable.comments.new(set_params)
    @comment.parent_id = @commentable.id if @commentable.class.name == 'Comment'
    respond_with @comment if @comment.save
  end

  def update_comment
    @comment = Comment.find(params[:id])
    @comment.update(set_params)
    respond_with(@comment)
  end

  def destroy_comment
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_with(@comment)
  end

  private

  def set_commentable
    controller_path.classify.constantize.find(params[:id])
  end

  def set_params
    params.require(:comment).permit(:body)
  end
end
