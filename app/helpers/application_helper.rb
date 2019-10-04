module ApplicationHelper
  def is_admin
    (current_user.has_role? :admin) ? true : false
  end

  def is_seller
    (current_user.has_role? :seller) ? true : false
  end

  def is_buyer
    (current_user.has_role? :buyer) ? true : false
  end

  def is_guest
    (current_user.has_role? :guest) ? true : false
  end
end
