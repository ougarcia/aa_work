
class Response < ActiveRecord::Base
  validates :answer_choice, presence: true
  validates :respondent, presence: true
  validate :respondent_has_not_already_answered_question
  validate :author_not_responding_to_own_poll

  belongs_to(
    :answer_choice,
    class_name: 'AnswerChoice',
    foreign_key: :answer_id,
    primary_key: :id
  )

  belongs_to(
    :respondent,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )

  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )



  def sibling_responses
    if self.id == nil
      self.question.responses
    else
      self.question.responses.where("id != ?", self.id)
    end
  end

  private

  def respondent_has_not_already_answered_question
    if sibling_responses.exists?(['user_id = ? AND answer_id = ? ', respondent, answer_choice])
      errors[:already_answered] << "User has already answered quesiton"
    end
  end

  def author_not_responding_to_own_poll
    if user_id == question.poll.author
      errors[:user_error] << "Author can't respond to their own poll"
    end
  end

end
