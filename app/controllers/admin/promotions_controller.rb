module Admin
  class PromotionsController < BaseController
    before_action :set_promotion, only: [:edit,:update, :show, :destroy]
    def index
      @promotions = Promotion.active
    end

    def new 
      @promotion = Promotion.new
    end

    def create
      promotion = Promotion.new({title: promotion_params[:title], expire_at: promotion_params[:expire_at], image: promotion_params[:image]})
      promotion.save

      redirect_to admin_promotions_path
    end

    def update
      @promotion.update!(promotion_params)
    end

    def destroy
      @promotion.destroy
      redirect_to admin_promotions_path
    end

    private
      def promotion_params
        params.require(:promotion).permit(:title, :image, :expire_at)
      end

      def set_promotion
        @promotion = Promotion.find_by(id: params[:id])
      end
  end
end