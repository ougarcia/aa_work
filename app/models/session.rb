class Session < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :session_token, presence: true
  validates :session_token, uniqueness: true

  def self.new_token
    SecureRandom.urlsafe_base64
  end
  
end
