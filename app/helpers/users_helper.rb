module UsersHelper
  def user_image(user)
    if user && user.image.attached?
        user.image
    else
        image_path('user.png')
    end
  end
end
