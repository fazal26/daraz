class CommentBroadcastJob < ApplicationJob
  queue_as :default

  def perform(product_id, comment_id, current_user_id)
    comment = Comment.find(comment_id)
    product = Product.find(product_id)

    return if comment.blank? && product.blank?

    ActionCable.server.broadcast "chat",{
      comment: render_comment(product, comment, current_user_id)
    }
  end

  private 
  def render_comment(product, comment, current_user_id)
    CommentsController.render(
      partial: 'comments/comment_detail',
      locals: {
        product: product,
        comment: comment,
        current_user_id: current_user_id
      }
    )
  end
end
