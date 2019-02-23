FactoryBot.define do
  factory :city do
    name { "Metropolis" }
    latitude { 100 }
    longitude { -100 }
    image { "https://image.com/image" }
  end
end
