class ShortenedUrl < ActiveRecord::Base
  validates :long_url, :presence => true
  validates :submitter, presence: true
  # validates :short_url, presence: true, uniqueness: true

  belongs_to(
    :submitter,
    :class_name => 'User',
    :foreign_key => :user_id,
    :primary_key => :id
  )

  has_many(
    :visits,
    :class_name => 'Visit',
    :foreign_key => :shortened_url_id,
    :primary_key => :id
  )

  has_many(:visitors, -> { distinct }, through: :visits, source: :visitor)

  def self.random_code
    code = ""
    loop do
      code = SecureRandom::urlsafe_base64
      break unless ShortenedUrl.exists?(short_url: code)
    end

    code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    options = {}
    options[:user_id] = user.id
    options[:long_url] = long_url
    options[:short_url] = ShortenedUrl.random_code
    result = ShortenedUrl.new(options)
    result.save!

    result
  end

  def num_clicks
    Visit.where(shortened_url_id: self.id).count
  end

  def num_uniques
    self.visitors.count
    # Visit.where(shortened_url_id: self.id).select(:user_id).distinct.count
  end

  def num_recent_uniques
    self.visitors.where(created_at: (10.minutes.ago)..Time.now).count
    # Visit.where("shortened_url_id = ? AND
    # created_at > ?", self.id, 9.minutes.ago).select(:user_id).distinct.count
  end
end
