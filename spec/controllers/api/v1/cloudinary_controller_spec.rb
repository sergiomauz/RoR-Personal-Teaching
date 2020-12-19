require 'rails_helper'

RSpec.describe Api::V1::CloudinaryController do
  describe 'GET #index' do
    # let(:token) do
    #   post '/api/v1/oauth/token', params: { username: 'sergio', password: '123456', grant_type: 'password' }
    #   JSON.parse(response.body)['token']
    # end

    context 'When the request is done without access token' do
      before do
        get :index
      end

      it 'Returns HTTP unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  # describe 'GET /users?me=true' do
  #   URL = '/v1/users?me=true'
  #   AUTH_URL = '/user_token'

  #   context 'when the request with NO authentication header' do
  #     it 'should return unauth for retrieve current user info before login' do
  #       get URL
  #       expect(response).to have_http_status(:unauthorized)
  #     end
  #   end

  #   context 'when the request contains an authentication header' do
  #     it 'should return the user info' do
  #       user  = create(:user)

  #       get URL, headers: authenticated_header(user)
  #       puts response.body
  #     end
  #   end
  # end
end
