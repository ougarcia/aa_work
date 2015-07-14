require_relative 'questions_database'
require_relative 'users'

class QuestionLike
  attr_accessor :id, :user_id, :question_id

  def self.all
    results = QuestionsDatabase.instance.execute('SELECT * FROM question_likes')
    results.map{|result| QuestionLike.new(result)}
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
       question_likes
      WHERE
        id = ?
    SQL

    QuestionLike.new(result)
  end

  def self.likers_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.id, users.fname, users.lname
      FROM
        question_likes
      INNER JOIN
        users ON question_likes.user_id = users.id
      WHERE
        question_likes.question_id = ?;
    SQL

    results.map { |result| User.new(result)}
  end

  def self.num_likes_for_question_id(question_id)
    result = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(*)
      FROM
        question_likes
      WHERE
        question_likes.question_id = ?

    SQL
    result.first["COUNT(*)"]

  end

  def self.liked_questions_for_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.id, questions.title, questions.body, questions.user_id
      FROM
        questions
      INNER JOIN
        question_likes ON questions.id = question_likes.question_id
      INNER JOIN
        users ON question_likes.user_id = users.id
      WHERE
        users.id = ? ;
    SQL

    results.map { |result| Question.new(result)}
  end

  def self.most_liked_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.id, questions.title, questions.body, questions.user_id
      FROM
        questions
      INNER JOIN
        question_likes ON questions.id = question_likes.question_id
      GROUP BY
        questions.id -- , questions.title, questions.body, questions.user_id
      ORDER BY
        COUNT(question_likes.id) DESC
      LIMIT
        ?;
    SQL
    results.map{|result| Question.new(result)}
  end

  def initialize(options = {})
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end


end

if __FILE__ == $PROGRAM_NAME
  # p QuestionLike.likers_for_question_id(1)
  # p QuestionLike.num_likes_for_question_id(1)
  # p QuestionLike.liked_questions_for_user_id(2)
  p QuestionLike.most_liked_questions(3)
end
