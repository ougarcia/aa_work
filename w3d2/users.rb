# User::find_by_name(fname, lname)
# User#authored_questions (use Question::find_by_author_id)
# User#authored_replies (use Reply::find_by_user_id)
require_relative 'questions_database'
require_relative 'questions'
require_relative 'question_follows'
require_relative 'replies'
require_relative 'question_likes'


class User
  attr_accessor :id, :fname, :lname

  def self.all
    results = QuestionsDatabase.instance.execute('SELECT * FROM users')
    results.map{|result| User.new(result)}
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
          *
        FROM
         users
        WHERE
          id = ?;
    SQL

    User.new(result[0])
  end

  def self.find_by_name(fname,lname)
    results = QuestionsDatabase.instance.execute(<<-SQL, fname,lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND
        lname = ?;
    SQL

    results.map{ |result| User.new(result) }
  end

  def self.average_karma(user_id)
    result = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SElECT
        CAST(COUNT(question_likes.id) AS FLOAT) / COUNT(DISTINCT questions.id) AS karma
      FROM
        questions
      LEFT OUTER JOIN
        question_likes ON question_likes.question_id = questions.id
      WHERE
        questions.user_id = ?;
    SQL

    result.first['karma']
  end


  def initialize(options = {})
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.new.liked_questions_for_user_id(@id)
  end

end

if __FILE__ == $PROGRAM_NAME
  # p User.find_by_id(2)
  # p User.find_by_name('Oscar', 'Garcia')
  our_user = User.find_by_id(1)
  our_user.followed_questions
  # p our_user.authored_questions
  # p our_user.authored_replies
  p User.average_karma(2)
end
