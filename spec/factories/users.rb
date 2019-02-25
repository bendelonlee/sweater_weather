FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "User#{n}@email.com" }
    password { "p" }

  end
end
