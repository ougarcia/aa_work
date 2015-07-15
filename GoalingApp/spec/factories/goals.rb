FactoryGirl.define do
  factory :goal do
    objective { Faker::Lorem.sentence }
  end
end
