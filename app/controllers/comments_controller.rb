class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @product = Product.find(comment_params[:product_id])
    @comment = @product.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save!
    render :create, layout: false
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy!
  end

  private
    def comment_params
      params.fetch(:comment).permit(:body, :product_id)
    end
end
