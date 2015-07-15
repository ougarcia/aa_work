# == Schema Information
#
# Table name: sessions
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  session_token :string(255)      not null
#  created_at    :datetime
#  updated_at    :datetime
#

class Session < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :session_token, presence: true
  validates :session_token, uniqueness: true

  def self.new_token
    token = SecureRandom.urlsafe_base64
  end

end
