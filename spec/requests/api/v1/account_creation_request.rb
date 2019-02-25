require "rails_helper"

describe 'Account creation' do
  def valid_params
    {
      "email": "whatever@example.com",
      "password": "password"
      "password_confirmation": "password"
    }
  end
  it 'creates a user and returns an api key' do
    post '/api/v1/users', params: valid_params
    expect(response).to be_successful
    expect(response.body).to have_key("api_key")
  end
end
