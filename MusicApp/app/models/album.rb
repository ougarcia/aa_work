class Album < ActiveRecord::Base
  PERFORMANCE_TYPES = %w(studio live)
  enum performance_type: [ :studio, :live ]
  belongs_to :band
  has_many :tracks, dependent: :destroy
  validates :band_id, :performance_type, :title, presence: true
  validates :performance_type, inclusion: { in: Album.performance_types.keys }
  validates :band, presence: true
  
end
