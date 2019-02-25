FactoryBot.define do
  factory :forecast do
    day_summary { "pretty outside" }
    week_summary { "it will get different as the week goes" }
    days_data { "{\"some\":\"data\"}" }
    hours_data { "{\"some\":\"data\"}" }
    city
  end
end
