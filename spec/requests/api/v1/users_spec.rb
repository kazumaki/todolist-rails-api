require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  describe "POST /create" do
    let(:valid_payload) { { user: { email: 'foo@bar.com', password: '123456' } } }
    
    context 'when the payload is valid' do
      before { post '/api/v1/users', params: valid_payload }

      it { expect(response.body[:user][:email]).to eq(valid_payload.email)  }
      it { expect(response).to have_http_status(:created) }
    end
  end
end
