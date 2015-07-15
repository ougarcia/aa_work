# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )
  has_many :post_subs
  has_many :subs, through: :post_subs
  has_many :comments, as: :commentable
  validates :title, presence: true
  validates :author, presence: true
  validates :subs, presence: true

  def comments_by_parent_id
    all_comments = Comment.includes(:author).where(parent_post_id: id)
    all_comments.inject(Hash.new { |h, k| h[k] = [] }) do |hash, comment|
      hash.tap do |h|
        if comment.commentable_type == "Comment"
          h[comment.commentable_id] << comment
        else
          h[nil] << comment
        end
      end
    end
  end
end
