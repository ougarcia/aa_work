# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


user = User.create!(user_name: 'Oscar')

second_user = User.create!(user_name: 'Bob')

poll = Poll.create!(title: 'test poll title', author_id: user.id)

first_question = Question.create!(text: "first question text", poll_id: poll.id)
second_question = Question.create!(text: "second question text", poll_id: poll.id)

first_answer_choice = AnswerChoice.create!(text: "First Answer Choice", question_id: first_question.id)
second_answer_choice = AnswerChoice.create!(text: "Second Answer Choice", question_id: first_question.id)

response = Response.create!(user_id: second_user.id, answer_id: first_answer_choice.id)
second_response = Response.create!(user_id: second_user.id, answer_id: second_answer_choice.id)
