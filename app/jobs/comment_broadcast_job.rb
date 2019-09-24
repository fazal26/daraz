class CommentBroadcastJob < ApplicationJob
  queue_as :default

  def perform(comment)
    ActionCable.server.broadcast "chat",{
      comment: render_comment(comment)
    }
  end

  private 
  def render_comment(c)
    CommentsController.render(
      partial: 'partials/comment/comment',
      locals: {
        comment: c
      }
    )
  
  end
end
