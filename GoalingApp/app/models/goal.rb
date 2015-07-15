class Goal < ActiveRecord::Base
  validates :user_id, :objective, presence: true
  validates :publicized, :completed, inclusion: { in: [true, false] }
  after_initialize :set_defaults
  belongs_to :user

  def set_defaults
    self.publicized ||= true
    self.completed ||= false
  end

  def self.public_goals
    Goal.includes(:user).where(publicized: true)
  end
end
