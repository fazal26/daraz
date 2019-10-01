module CommentsHelper
  def is_commenter(user_id)
    user_id == current_user.id
  end
end
