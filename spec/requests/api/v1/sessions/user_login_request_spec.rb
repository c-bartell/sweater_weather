require 'rails_helper'

describe 'Sessions POST request' do
  it 'can return a registered user\'s api key' do
    email = 'elfo@dreamland.com'
    password = 'i_heart_bean'
    user = User.create!(
      email: email,
      password: password,
      password_confirmation: password
    )
    headers = {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }

    post api_v1_sessions_path(email: email, password: password), headers: headers

    expect(response).to have_http_status 200

    parsed_data = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_data).to have_key :data
    expect(parsed_data[:data]).to be_a Hash

    user_data = parsed_data[:data]

    expect(user_data).to have_key :type
    expect(user_data[:type]).to eq 'users'
    expect(user_data).to have_key :id
    expect(user_data[:id]).to eq user.id.to_s
    expect(user_data).to have_key :attributes
    expect(user_data[:attributes]).to be_a Hash

    attributes = user_data[:attributes]

    expect(attributes).to have_key :email
    expect(attributes[:email]).to eq user.email
    expect(attributes).to have_key :api_key
    expect(attributes[:api_key]).to eq user.api_key
  end
end
