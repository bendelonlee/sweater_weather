require "rails_helper"

describe 'Account creation' do
  def valid_creation_params
    {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }
  end
  def valid_login_params
    {
      "email": "whatever@example.com",
      "password": "password",
    }
  end
  it 'creates a user and returns an api key, then allows them to log in with that key' do
    post '/api/v1/users', params: valid_creation_params
    expect(response).to be_successful
    body = JSON.parse(response.body)
    expect(body).to have_key("api_key")
    api_key = body["api_key"]

    post '/api/v1/sessions', params: valid_login_params
    expect(response).to be_successful
    expect(JSON.parse(response.body)["api_key"]).to eq(api_key)
  end
end
