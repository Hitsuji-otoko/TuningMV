FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "test#{n}"}
    sequence(:email) { |n| "test#{n}@test.com"}
    password { "password" }
  end
end