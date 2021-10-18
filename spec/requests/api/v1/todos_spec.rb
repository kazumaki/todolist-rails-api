require 'rails_helper'

RSpec.describe "Api::V1::Todos", type: :request do
  describe "GET /index" do
    let!(:user) { create(:user) }
    let!(:todo_list) { create_list(:todo, 5, user: user) }
    context 'when the user is logged in' do
      before { get '/api/v1/todos', headers: { 'Authorization': JWT.encode({user_id: user.id}, Rails.application.secrets.secret_key_base.to_s)}}
      it { expect(JSON.parse(response.body)).to have_attributes(length: 5) }
      it { expect(response).to have_http_status(:ok) }
    end

    context 'when the header token is invalid' do
      before { get '/api/v1/todos' }
      it { expect(response).to have_http_status(:unauthorized) }
    end
  end
end
