module Admin::PromotionsHelper
  def promo_image(promo)
    if promo && promo.image.attached?
        promo.image
    else
        image_path('user.png')
    end
  end
end
