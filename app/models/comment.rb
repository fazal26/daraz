class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  after_create_commit :broadcast

  private
    def broadcast
      CommentBroadcastJob.perform_later(self.product.id, self.id);
    end
end
