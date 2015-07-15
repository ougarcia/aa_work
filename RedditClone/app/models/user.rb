# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :email, length: { minimum: 6 }
  after_initialize :ensure_session_token

  has_many(
    :created_subs,
    class_name: 'Sub',
    foreign_key: :user_id,
    primary_key: :id
  )
  has_many :posts
  has_many :comments


  attr_reader :password

  def self.generate_new_session_token
    SecureRandom.urlsafe_base64
  end

  def self.find_by_credentials(attrs)
    user = User.find_by(email: attrs[:email])
    if user && user.is_password?(attrs[:password])
      user
    else
      nil
    end
  end

  def reset_session_token!
    self.session_token = User.generate_new_session_token
    self.save!
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  private


  def ensure_session_token
    self.session_token ||= User.generate_new_session_token
  end
end
