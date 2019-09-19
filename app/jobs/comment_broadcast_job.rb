class CommentBroadcastJob < ApplicationJob
  queue_as :default

  def perform(comment)
    puts "JOB PERFORM\n"*5
    ActionCable.server.broadcast "chat",{
      comment: render_comment(comment),
      parent_id: comment.parent_id || nil
    }
  end

  private 
  def render_comment(c)
    puts "RENDER COMMENT\n"*5
    CommentsController.render(
      partial: 'partials/comment/comment',
      locals: {
        comment: c,
        parent_id: c.parent_id
      }
    )
  
  end
end
