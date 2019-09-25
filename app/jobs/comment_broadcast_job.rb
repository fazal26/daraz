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
      partial: 'comment_detail',
      locals: {
        comment: c
      }
    )
  
  end
end
