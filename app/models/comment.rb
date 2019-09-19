class Comment < ApplicationRecord
  belongs_to :user

  after_create_commit {
    CommentBroadcastJob.perform_later(self);
  }
end
