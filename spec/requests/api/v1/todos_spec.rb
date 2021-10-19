require 'rails_helper'

RSpec.describe "Api::V1::Todos", type: :request do
  let!(:user) { create(:user) }
  let!(:authorization_token) { JWT.encode({user_id: user.id}, Rails.application.secrets.secret_key_base.to_s) }
  describe "GET /todos" do
    let!(:todo_list) { create_list(:todo, 5, user: user) }


    context 'when the authorization token is valid' do
      before { get '/api/v1/todos', headers: { 'Authorization': authorization_token }}
      it { expect(JSON.parse(response.body)).to have_attributes(length: 5) }
      it { expect(response).to have_http_status(:ok) }
    end

    context 'when the authorization token is invalid' do
      before { get '/api/v1/todos' }
      it { expect(response).to have_http_status(:unauthorized) }
    end
  end

  describe "POST /todos" do
    let!(:valid_payload) { { todo: { name: 'testodo' } } }
    context 'when the authorization token and payload are valid' do
      before { post '/api/v1/todos', params: valid_payload, headers: { 'Authorization': authorization_token }}
      it { expect(JSON.parse(response.body)['name']).to eq('testodo') }
      it { expect(response).to have_http_status(:created) }
    end

    context 'when the authorization token is valid and payload is invalid' do
      before { post '/api/v1/todos', params: { todo: { name: '' } }, headers: { 'Authorization': authorization_token }}
      it { expect(response).to have_http_status(:unprocessable_entity) }
    end

    context 'when the authorization token is invalid' do
      before { post '/api/v1/todos', params: valid_payload }
      it { expect(response).to have_http_status(:unauthorized) }
    end
  end
end
