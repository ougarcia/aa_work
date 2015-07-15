class Contact < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { scope: :name }

  has_many(:contact_shares)
  has_many(:shared_users, through: :contact_shares, source: :user)

  belongs_to(
    :owner,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many :comments, as: :commentable
end
