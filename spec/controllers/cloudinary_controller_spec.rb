require 'rails_helper'

RSpec.describe Api::V1::CloudinaryController do
  before(:all) do
    FactoryBot.create(:user,
                      username: 'admin',
                      password: '123456',
                      fullname: 'Super Administrator',
                      email: 'admin@example.xyz',
                      admin: true)
    FactoryBot.create(:user,
                      username: 'student',
                      password: '123456',
                      fullname: 'Eternal Student',
                      email: 'student@example.xyz',
                      admin: false)
  end

  describe 'GET #index' do
    let(:user_first_id) { User.first.id }
    let(:user_last_id) { User.last.id }

    let(:admin_session) { Doorkeeper::AccessToken.create!(resource_owner_id: user_first_id, expires_in: 1.hours) }
    let(:not_admin_session) { Doorkeeper::AccessToken.create!(resource_owner_id: user_last_id, expires_in: 1.hours) }

    render_views

    context 'When the request is done without access token' do
      it 'Returns HTTP unauthorized' do
        get :index, format: :json

        expect(response).to have_http_status(:unauthorized)
      end

      it 'Returns HTTP forbidden if use -not_admin_session-' do
        headers = { 'Authorization': 'Bearer ' + not_admin_session.token }
        request.headers.merge! headers
        get :index, format: :json

        expect(response).to have_http_status(:forbidden)
      end

      it 'Returns HTTP success if use -admin_session-' do
        headers = { 'Authorization': 'Bearer ' + admin_session.token }
        request.headers.merge! headers
        get :index, format: :json

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).keys).to match_array(%w[cloud_name upload_preset])
      end
    end
  end
end
