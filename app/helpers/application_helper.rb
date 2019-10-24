module ApplicationHelper
  def is_admin
    current_user.has_role? :admin
  end

  def is_seller
    current_user.has_role? :seller
  end

  def is_buyer
    current_user.has_role? :buyer
  end
end
