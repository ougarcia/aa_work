# Reply::find_by_user_id(user_id)
# Reply::find_by_question_id(question_id)
# Reply#author
# Reply#question
# Reply#parent_reply
# Reply#child_replies

require_relative 'questions_database'
require_relative 'users'

class Reply
  attr_accessor :id, :body, :user_id, :question_id, :parent_id

  def self.all
    results = QuestionsDatabase.instance.execute('SELECT * FROM replies')
    results.map{|result| Reply.new(result)}
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
       replies
      WHERE
        id = ?
    SQL

    Reply.new(result[0])
  end

  def self.find_by_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
       replies
      WHERE
        user_id = ?
    SQL

    results.map { |result| Reply.new(result)}
  end

  def self.find_by_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
       replies
      WHERE
        question_id = ?
    SQL

    results.map { |result| Reply.new(result)}

  end


  def initialize(options = {})
    @id = options['id']
    @question_id = options['question_id']
    @parent_id = options['parent_id']
    @user_id = options['user_id']
    @body = options['body']
  end

  def author
    User.find_by_id(@user_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    Reply.find_by_id(@parent_id)
  end

  def child_replies
    results = QuestionsDatabase.instance.execute(<<-SQL, @id)
    SELECT
      *
    FROM
      replies
    WHERE
      parent_id = ?;
    SQL

    results.map {|result| Reply.new(result)}
  end
end


if __FILE__ == $PROGRAM_NAME
  first_reply = Reply.find_by_id(1)
  # p Reply.find_by_question_id(1)
  p first_reply.child_replies
end
