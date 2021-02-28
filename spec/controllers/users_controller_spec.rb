# rubocop: disable Metrics/BlockLength
require 'rails_helper'

RSpec.describe Api::V1::UsersController do
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
    FactoryBot.create(:user,
                      username: 'employee',
                      password: '123456',
                      fullname: 'Good Employee',
                      email: 'employee@example.xyz',
                      admin: false)

    FactoryBot.create(:teacher,
                      fullname: 'Neil deGrasse Tyson',
                      course: 'Physics',
                      description: 'Magnetars and Pulsars',
                      email: 'neil@xmail.xyz',
                      photo: 'https://localhost:8080/image1.png')
    FactoryBot.create(:teacher,
                      fullname: 'Julio Profe PuntoNet',
                      course: 'Math',
                      description: 'Limits and derivatives',
                      email: 'julio@xmail.xyz',
                      photo: 'https://localhost:8080/image2.png')
    FactoryBot.create(:teacher,
                      fullname: 'Sergio Zambrano',
                      course: 'Computer Science',
                      description: 'Algorithms and Artificial Intelligence',
                      email: 'sergio@xmail.xyz',
                      photo: 'https://localhost:8080/image3.png')

    FactoryBot.create(:appointment,
                      teacher_id: Teacher.first.id,
                      user_id: User.first.id,
                      scheduled_for: Time.now.utc.next_day(1).to_s[0..9])
    FactoryBot.create(:appointment,
                      teacher_id: Teacher.first.id,
                      user_id: User.last.id,
                      scheduled_for: Time.now.utc.next_day(1).to_s[0..9])
  end

  describe 'Tests for USERS controller' do
    let(:user_first_id) { User.first.id }
    let(:user_last_id) { User.last.id }

    let(:admin_session) { Doorkeeper::AccessToken.create!(resource_owner_id: user_first_id, expires_in: 1.hours) }
    let(:not_admin_session) { Doorkeeper::AccessToken.create!(resource_owner_id: user_last_id, expires_in: 1.hours) }

    render_views

    context 'GET #index' do
      it 'Returns HTTP unauthorized if do not use a session' do
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
        expect(JSON.parse(response.body).keys).to match_array(['users'])
      end
    end

    context 'GET #myprofile' do
      it 'Returns HTTP unauthorized if do not use a session' do
        get :myprofile, format: :json

        expect(response).to have_http_status(:unauthorized)
      end

      it 'Returns HTTP success if use -not_admin_session-' do
        headers = { 'Authorization': 'Bearer ' + not_admin_session.token }
        request.headers.merge! headers
        get :myprofile, format: :json

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).keys).to match_array(['myprofile'])
      end

      it 'Returns HTTP success if use -admin_session-' do
        headers = { 'Authorization': 'Bearer ' + admin_session.token }
        request.headers.merge! headers
        get :myprofile, format: :json

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).keys).to match_array(['myprofile'])
      end
    end

    context 'GET #show for User with ID = 1' do
      it 'Returns HTTP unauthorized if do not use a session' do
        get :show, params: { id: user_last_id }, format: :json

        expect(response).to have_http_status(:unauthorized)
      end

      it 'Returns HTTP forbidden if use -not_admin_session-' do
        headers = { 'Authorization': 'Bearer ' + not_admin_session.token }
        request.headers.merge! headers
        get :show, params: { id: user_last_id }, format: :json

        expect(response).to have_http_status(:forbidden)
      end

      it 'Returns HTTP success if use -admin_session-' do
        headers = { 'Authorization': 'Bearer ' + admin_session.token }
        request.headers.merge! headers
        get :show, params: { id: user_last_id }, format: :json

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).keys).to match_array(['user'])
      end
    end

    context 'GET #last' do
      it 'Returns HTTP unauthorized if do not use a session' do
        get :last, format: :json

        expect(response).to have_http_status(:unauthorized)
      end

      it 'Returns HTTP forbidden if use -not_admin_session-' do
        headers = { 'Authorization': 'Bearer ' + not_admin_session.token }
        request.headers.merge! headers
        get :last, format: :json

        expect(response).to have_http_status(:forbidden)
      end

      it 'Returns HTTP success if use -admin_session-' do
        headers = { 'Authorization': 'Bearer ' + admin_session.token }
        request.headers.merge! headers
        get :last, format: :json

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).keys).to match_array(['user'])
      end
    end

    context 'GET #myappointments' do
      it 'Returns HTTP unauthorized if do not use a session' do
        get :myappointments, format: :json

        expect(response).to have_http_status(:unauthorized)
      end

      it 'Returns HTTP forbidden if use -not_admin_session-' do
        headers = { 'Authorization': 'Bearer ' + not_admin_session.token }
        request.headers.merge! headers
        get :myappointments, format: :json

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).keys).to match_array(['appointments'])
      end

      it 'Returns HTTP success if use -admin_session-' do
        headers = { 'Authorization': 'Bearer ' + admin_session.token }
        request.headers.merge! headers
        get :myappointments, format: :json

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).keys).to match_array(['appointments'])
      end
    end

    context 'POST #create' do
      it 'Returns HTTP unauthorized if do not use a session' do
        post :create, params: {
          user: {
            fullname: 'Another Good Student',
            email: 'another@xmail.xyz',
            username: 'another',
            password: '123456'
          }
        }, format: :json

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).keys).to match_array(['user'])
      end
    end

    context 'PUT #update for User with ID = 3' do
      it 'Returns HTTP unauthorized if do not use a session' do
        put :update,
            params: { id: user_last_id, user: {
              fullname: 'Another Good Student',
              email: 'another@xmail.xyz',
              username: 'another',
              password: '123456'
            } },
            format: :json

        expect(response).to have_http_status(:unauthorized)
      end

      it 'Returns HTTP forbidden if use -not_admin_session-' do
        headers = { 'Authorization': 'Bearer ' + not_admin_session.token }
        request.headers.merge! headers
        put :update,
            params: { id: user_last_id, user: {
              fullname: 'Another Good Student',
              email: 'another@xmail.xyz',
              username: 'another',
              password: '123456'
            } },
            format: :json

        expect(response).to have_http_status(:forbidden)
      end

      it 'Returns HTTP success if use -admin_session-' do
        headers = { 'Authorization': 'Bearer ' + admin_session.token }
        request.headers.merge! headers
        put :update,
            params: { id: user_last_id, user: {
              fullname: 'Another Good Student',
              email: 'another@xmail.xyz',
              username: 'another',
              password: '123456'
            } },
            format: :json

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).keys).to match_array(['user'])
      end
    end

    context 'DELETE #destroy' do
      it 'Returns HTTP unauthorized if do not use a session' do
        delete :destroy, params: { id: user_last_id }, format: :json

        expect(response).to have_http_status(:unauthorized)
      end

      it 'Returns HTTP forbidden if use -not_admin_session-' do
        headers = { 'Authorization': 'Bearer ' + not_admin_session.token }
        request.headers.merge! headers
        delete :destroy, params: { id: user_last_id }, format: :json

        expect(response).to have_http_status(:forbidden)
      end

      it 'Returns HTTP success if use -admin_session-' do
        headers = { 'Authorization': 'Bearer ' + admin_session.token }
        request.headers.merge! headers
        delete :destroy, params: { id: user_last_id }, format: :json

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).keys).to match_array(['user'])
      end
    end
  end
end
# rubocop: enable Metrics/BlockLength
