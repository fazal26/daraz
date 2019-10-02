class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @product = Product.find(comment_params[:product_id])
    @comment = @product.comments.build(comment_params)
    @comment.save!
    render :create, layout: false
  end

  def edit
    @product = Product.find(params[:product_id])
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy!
  end

  private
    def comment_params
      params.fetch(:comment).permit(:body, :product_id, :id).tap do |whitelist|
        whitelist[:user_id] = current_user.id
      end
    end
end
