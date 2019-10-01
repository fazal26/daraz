class CommentBroadcastJob < ApplicationJob
  queue_as :default

  def perform(product_id, comment_id)
    comment = Comment.find(comment_id)
    product = Product.find(product_id)

    return if comment.blank? && product.blank?

    ActionCable.server.broadcast "chat",{
      comment: render_comment(product, comment)
    }
  end

  private 
  def render_comment(product, comment)
    CommentsController.render(
      partial: 'comments/comment_detail',
      locals: {
        product: product,
        comment: comment
      }
    )
  end
end
