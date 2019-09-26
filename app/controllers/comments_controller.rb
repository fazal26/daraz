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

  def destroy
    puts "------------\n"*10, params.inspect
    comment = Comment.find(params[:id])
    comment.destroy!
    redirect_back(fallback_location: root_path)
  end

  private
    def comment_params
      params.fetch(:comment).permit(:body, :product_id, :id)
    end
end
