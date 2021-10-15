require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  describe "POST /create" do
    let(:valid_payload) { { user: { email: 'foo@bar.com', password: '123456', password_confirmation: '123456' } } }

    context 'when the payload is valid' do
      before { post '/api/v1/users', params: valid_payload }

      it { expect(JSON.parse(response.body)["email"]).to eq(valid_payload[:user][:email])  }
      it { expect(response).to have_http_status(:created) }
    end

    context 'when the email is invalid' do
      before { post '/api/v1/users', params: { user: { email: 'foo@bar', password: '123456', password_confirmation: '123456' } } }

      it { expect(JSON.parse(response.body)['email'].first).to eq('is invalid')}
      it { expect(response).to have_http_status(:unprocessable_entity) }
    end

    context 'when the password id invalid' do
      before { post '/api/v1/users', params: { user: { email: 'foo@bar.com', password: '', password_confirmation: ''} } }

      it { expect(JSON.parse(response.body)['password'].first).to eq("can't be blank")}
      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end
end
