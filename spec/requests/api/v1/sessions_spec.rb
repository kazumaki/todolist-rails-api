require 'rails_helper'

RSpec.describe "Api::V1::Sessions", type: :request do
  let(:valid_user) { User.create(email: 'foo@bar.foo', password: '123456') }

  describe "POST /sessions" do
    context 'when the user data is valid' do
      before { post '/api/v1/sessions', params: { user: { email: valid_user.email, password: valid_user.password } } }
    end
  end
end
