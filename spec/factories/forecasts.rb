FactoryBot.define do
  factory :forecast do
    day_summary { "MyString" }
    week_summary { "MyString" }
    city { nil }
  end
end
