require 'rails_helper'

RSpec.describe "Api::V1::Todos", type: :request do
  describe "GET /index" do
    let!(:user) { create(:user) }
    let!(:todo_list) { create_list(:todo, 5, user: user) }
    context 'when the user is logged in' do
      before { get '/api/v1/todos' }
      it { expect(response).to have_http_status(:ok) }
    end
  end
end
