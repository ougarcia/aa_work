

User.create!(username: "YoungKeezy")
User.create!(username: "Oscar")
User.create!(username: "Fernando")

Contact.create!( name: "Kevin", email: "kevin@xu.com", user_id: 1)
Contact.create!( name: "oscar", email: "oscar@gmail.com", user_id: 2)
Contact.create!( name: "Fernando", email: "fernando@fernando.io", user_id: 3 )

ContactShare.create!(user_id: 1, contact_id: 3)
ContactShare.create!(user_id: 1, contact_id: 2)
ContactShare.create!(user_id: 2, contact_id: 2)
ContactShare.create!(user_id: 2, contact_id: 1)

Comment.create!(body: "hey hey hey", commentable_id: 1, commentable_type: 'User')

