class Track < ActiveRecord::Base
  belongs_to :album
  has_one :band, through: :album, source: :band
  has_many :notes
  enum track_type: [ :regular, :bonus ]
  validates :title, :track_type, :album_id, presence: true
  validates :track_type, inclusion: { in: Track.track_types.keys }
  validates :album, presence: true
  
end
