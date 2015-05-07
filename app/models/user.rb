
class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true
  
  has_many(
    :responses,
    class_name: 'Response',
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :authored_polls,
    class_name: 'Poll',
    foreign_key: :author_id,
    primary_key: :id
  )

  def completed_polls
    #start by getting the questions per poll
    Poll.find_by_sql(<<-SQL, id)
      SELECT
        polls.*, COUNT(questions.id)
      FROM
        polls
      JOIN
        questions ON poll.id = questions.poll_id
      JOIN
        answer_choices ON questions.id = answer_choices.question_id
      LEFT OUTER JOIN(
        SELECT
          *
        FROM
          responses
        WHERE
          user_id = ?
        ) AS sub_responses ON sub_responses.user_id = user.id
      GROUP BY
        polls.id
      HAVING
        COUNT(questions.id) = COUNT(responses.id)
    SQL

  end

end
