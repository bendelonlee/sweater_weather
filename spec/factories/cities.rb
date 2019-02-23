FactoryBot.define do
  factory :city do
    name { "Metropolis" }
    latitude { 100.10 }
    longitude { -100.01 }
    image { "https://image.com/image" }
  end
end
