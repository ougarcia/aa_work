
class Question < ActiveRecord::Base
  validates :text, presence: true
  validates :poll, presence: true

  has_many(
    :answer_choices,
    class_name: 'AnswerChoice',
    foreign_key: :question_id,
    primary_key: :id
  )

  belongs_to(
    :poll,
    class_name: 'Poll',
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many(
    :responses,
    through: :answer_choices,
    source: :responses
  )

  def results
    choice_response_counts = {}
    answer_choices
      .select("answer_choices.*, COUNT(responses.id) AS response_count")
      .joins("LEFT OUTER JOIN responses ON responses.answer_id = answer_choices.id")
      .group("answer_choices.id")
      .each do |answer_choice|
        choice_response_counts[answer_choice.text] = answer_choice.response_count
      end
        
    choice_response_counts
  end
end
