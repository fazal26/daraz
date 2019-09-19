class Comment < ApplicationRecord
  belongs_to :user
  has_many :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy
  belongs_to :commentable, polymorphic: true

  after_create_commit {
    puts "AFTER COMMIT\n"*5
    CommentBroadcastJob.perform_later(self);
  }
end
