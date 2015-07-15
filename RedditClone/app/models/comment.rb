# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  content          :string           not null
#  user_id          :integer          not null
#  commentable_id   :integer          not null
#  commentable_type :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  belongs_to(
    :author,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )
  validates :author, :content, :commentable_id, :commentable_type, presence: true

  def direct_parent
    self.commentable_type.constantize.find(commentable_id)
  end

  def root_parent
    parent = direct_parent
    parent.is_a?(Post) ? parent : parent.root_parent
  end

end
