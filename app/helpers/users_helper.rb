module UsersHelper
  def user_image(user)
    if user.image.attached?
        user.image
    else
        image_path('user.png')
    end
  end
end
