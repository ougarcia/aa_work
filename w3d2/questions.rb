# Question::find_by_author_id(author_id)
# Question#author
# Question#replies (use Reply::find_by_question_id)

require_relative 'users'
require_relative 'question_follows'
require_relative 'questions_database'
require_relative 'question_likes'

class Question
  attr_accessor :id, :title, :body, :user_id

  def self.all
    results = QuestionsDatabase.instance.execute('SELECT * FROM questions')
    results.map{|result| Question.new(result)}
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
       questions
      WHERE
        id = ?;
    SQL

    Question.new(result[0])
  end

  def self.find_by_author_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
       questions
      WHERE
        user_id = ?;
    SQL

    results.map{|result| Question.new(result)}
  end

  def self.most_followed(n)
    result_hashes = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.id, questions.title, questions.body, questions.user_id
      FROM
        questions
      JOIN
        question_follows ON questions.id = question_follows.question_id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(question_follows.id) DESC
      LIMIT
       ?
    SQL
    result_hashes.map {|result| Question.new(result)}
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  def initialize(options = {})
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end

  def author
    User.find_by_id(@user_id)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollow.follower_for_question_id(@id)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end
end

if __FILE__ == $PROGRAM_NAME
  # p Question.find_by_author_id(1)
  our_question = Question.find_by_id(3)
  # p our_question.followers
  p Question.most_followed(4)
end
