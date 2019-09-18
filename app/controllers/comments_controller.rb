class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @product = Product.find(comment_params[:product_id])
    @comment = @product.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save!
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :product_id, :id, :parent_id)
  end
end
