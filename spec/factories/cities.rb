FactoryBot.define do
  factory :city do
    name { "Metropolis" }
    latitude { 32.7157 }
    sequence(:longitude) { |n| 117.1611 - n * 2 }
    image { "https://image.com/image" }
    country { "United States"}
  end
end
