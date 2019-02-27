require "rails_helper"
describe 'optimization' do
  before(:each) do
    REDIS.redis.flushdb
  end
  it 'if I search for denver, then I search denver,CO or denver,Colorado it finds the same city each time' do
    VCR.use_cassette('denver_name_agnostic') do
      get "/api/v1/forecast?location=Denver"
      get "/api/v1/forecast?location=denver"
      get "/api/v1/forecast?location=denver,CO"
      get "/api/v1/forecast?location=denver,Colorado"
    end
    expect(City.count).to eq(1)
  end
  it 'if I search for a city by the same name twice, it does not make a call to the geocoder the second time' do
    #ideally I would set up a redis test database. Haven't yet.
    VCR.use_cassette('denver_name_remembered') do
      get "/api/v1/forecast?location=Denver,CO"
    end
    get "/api/v1/forecast?location=Denver,CO"
    # this test errors by giving a VCR::Errors::UnhandledHTTPRequestError and passes by not giving that error.
  end
end
