module Admin
  class PromotionsController < BaseController
    before_action :set_promotion, only: [:edit, :show, :destroy]
    def index
      @promotions = Promotion.active
    end

    def new 
      @promotion = Promotion.new
    end

    def create
    end

    def update
      @promotion.update(promotion_params)
    end

    def destroy
      @promotion.destroy
    end

    private
    def promotion_params
    end

    def set_promotion
      @promotion = Promotion.find_by(id: promotion_params[:id])
    end
  end
end