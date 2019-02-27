require "rails_helper"
describe City::Name do
  it "it stores names as keys and ids as values" do
    City::Name["wonderland"] = 1
    expect(City::Name["wonderland"]).to eq('1')
  end
end
