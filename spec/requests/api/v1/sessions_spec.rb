require 'rails_helper'

RSpec.describe "Api::V1::Sessions", type: :request do
  let(:valid_user) { User.create(email: 'foo@bar.foo', password: '123456', password_confirmation: '123456') }

  describe "POST /sessions" do
    context 'when the user data is valid' do
      before { post '/api/v1/sessions', params: { user: { email: valid_user.email, password: valid_user.password } } }

      it { expect(JSON.parse(response.body)).to have_key('token') }
      it { expect(JSON.parse(response.body)).to have_key('user') }
      it { expect(response).to have_http_status(:created) }
    end

    context 'when the password is invalid' do
      before { post '/api/v1/sessions', params: { user: { email: valid_user.email, password: '1234' } } }

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end

    context 'when the email is invalid' do
      before { post '/api/v1/sessions', params: { user: { email: 'foo@bar', password: '123456' } } }

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end
end
