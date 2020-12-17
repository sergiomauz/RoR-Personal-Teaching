require 'rails_helper'

RSpec.describe Api::V1::UsersController do
  describe 'Tests for USERS controller' do
    render_views
    context 'GET #index' do
      let(:admin_session) { Doorkeeper::AccessToken.create!(:resource_owner_id => 1, :expires_in => 1.hours) }
      let(:not_admin_session) { Doorkeeper::AccessToken.create!(:resource_owner_id => 2, :expires_in => 1.hours) }
      
      before do
        FactoryBot.create(:user, id: 1, username: 'admin', fullname: 'Super Administrator', email: 'admin@example.xyz', admin: true)
        FactoryBot.create(:user, id: 2, username: 'student', fullname: 'Eternal Student', email: 'student@example.xyz', admin: false)        
      end

      it 'Returns HTTP success if use -admin_session-' do
        headers = { 'Authorization': 'Bearer ' + admin_session.token }
        request.headers.merge! headers        
        get :index, format: :json
        
        expect(response).to have_http_status(:success) 
        expect(JSON.parse(response.body).keys).to match_array(['users'])
      end
    end
  end
end
