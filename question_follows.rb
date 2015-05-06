require_relative 'users'
require_relative 'questions'

class QuestionFollow
  attr_accessor :id, :question_id, :user_id

  def self.all
    results = QuestionsDatabase.instance.execute('SELECT * FROM question_follows')
    results.map{|result| QuestionFollow.new(result)}
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
       question_follows
      WHERE
        id = ?
    SQL

    QuestionFollow.new(result)
  end


  def self.follower_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        user_id
      FROM
        question_follows
      WHERE
        question_id = ?;
    SQL

    # [{'user_id' => 1}, {'user_id' => 2}, {'user_id' => 3}]

    results.map { |result| User.find_by_id(result['user_id']) }
  end

  def self.followed_questions_for_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        question_id
      FROM
        question_follows
      WHERE
        user_id = ?;
    SQL
    results.map {|result| Question.find_by_id(result['question_id'])}
  end

  def self.most_followed_questions(n)
    results_hash = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.id, questions.title, questions.body, questions.user_id
      FROM
        question_follows
      INNER JOIN
        questions ON question_follows.question_id = questions.id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(question_follows.id) DESC
      LIMIT
        ?;

    SQL


    results_hash.map { |results_hash| Question.new(results_hash) }
  end




  def initialize(options = {})
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end


end


if __FILE__ == $PROGRAM_NAME
  # p QuestionFollow.follower_for_question_id(3)
  p QuestionFollow.most_followed_questions(5)
end
