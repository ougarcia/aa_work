class TagTopic

  validates :topic, presence: true

  has_many(
    :taggings,
    class_name: 'Tagging',
    foreign_key: :topic_id,
    primary_key: :id
  )

  has_many :urls, through: :taggings, source: :url

  def self.add_topic(topic)
    TagTopic.new(topic: topic).save!
  end
end
