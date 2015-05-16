# == Schema Information
#
# Table name: subs
#
#  id          :integer          not null, primary key
#  title       :string
#  description :string
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Sub < ActiveRecord::Base
  belongs_to(
    :moderator,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )
  has_many :post_subs
  has_many :posts, through: :post_subs
  validates :title, :description, :moderator, presence: true
end
