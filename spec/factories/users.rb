FactoryGirl.define do
  factory :user do
      username { Faker::Name.name }
      password { Faker::Internet.password(6, 10) }
      session_token { SecureRandom.urlsafe_base64 }
  end
end
