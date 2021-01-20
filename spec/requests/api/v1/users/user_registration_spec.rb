require 'rails_helper'

describe 'User POST request' do
  it 'can create a user and return an api_key' do
    email = 'elfo@dreamland.com'
    password = 'i_heart_bean'
    headers = {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }

    post api_v1_users_path(email: email, password: password, password_confirmation: password)

    user = User.last
    expect(user.email).to eq email
    expect(user.password).to be_a String
    expect(user.api_key).to_not be_empty
    expect(user.api_key).to be_a String

    expect(response).to have_http_status 201

    parsed_data = JSON.parse(respons.body, symbolize_names: true)

    expect(parsed_data).to have_key :data
    expect(parsed_data[:data]).to be_a Hash

    user_data = parsed_data[:data]

    expect(user_data).to have_key :type
    expect(user_data[:type]).to eq 'users'
    expect(user_data).to have_key :id
    expect(user_data[:id]).to eq user.id
    expect(user_data).to have_key :attributes
    expect(user_data[:attributes]).to be_a Hash

    attributes = user_data[:attributes]

    expect(attributes).to have_key :email
    expect(attributes[:email]).to eq email
    expect(attributes).to have_key :api_key
    expect(attributes[:api_key]).to eq user.api_key
    expect(attributes).to_not have_key :password
  end

  # sad path with 400 codes goes here
end
