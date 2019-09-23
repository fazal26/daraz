class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  after_create_commit {
    CommentBroadcastJob.perform_later(self);
  }
end
