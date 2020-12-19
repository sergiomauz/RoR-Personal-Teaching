# rubocop: disable Metrics/BlockLength
require 'rails_helper'

RSpec.describe Api::V1::TeachersController do
  before(:all) do
    FactoryBot.create(:user,
                      username: 'admin',
                      fullname: 'Super Administrator',
                      email: 'admin@example.xyz',
                      admin: true)
    FactoryBot.create(:user,
                      username: 'student',
                      fullname: 'Eternal Student',
                      email: 'student@example.xyz',
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
  end

  describe 'Tests for TEACHERS controller' do
    let(:teacher_last_id) { Teacher.last.id }
    let(:user_first_id) { User.first.id }
    let(:user_last_id) { User.last.id }
    let(:appointment_first_id) { Appointment.first.id }

    let(:admin_session) { Doorkeeper::AccessToken.create!(resource_owner_id: user_first_id, expires_in: 1.hours) }
    let(:not_admin_session) { Doorkeeper::AccessToken.create!(resource_owner_id: user_last_id, expires_in: 1.hours) }    
    let(:date_for_testing_appointments) { Time.now.utc.next_day(1).to_s[0..9] }

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

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).keys).to match_array(['teachers'])
      end

      it 'Returns HTTP success if use -admin_session-' do
        headers = { 'Authorization': 'Bearer ' + admin_session.token }
        request.headers.merge! headers
        get :index, format: :json

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).keys).to match_array(['teachers'])
      end
    end

    context 'GET #show for Teacher with ID = teacher_last_id' do
      it 'Returns HTTP unauthorized if do not use a session' do
        get :show, params: { id: teacher_last_id }, format: :json

        expect(response).to have_http_status(:unauthorized)
      end

      it 'Returns HTTP success if use -not_admin_session-' do
        headers = { 'Authorization': 'Bearer ' + admin_session.token }
        request.headers.merge! headers
        get :show, params: { id: teacher_last_id }, format: :json

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).keys).to match_array(['teacher'])
      end

      it 'Returns HTTP success if use -admin_session-' do
        headers = { 'Authorization': 'Bearer ' + admin_session.token }
        request.headers.merge! headers
        get :show, params: { id: teacher_last_id }, format: :json

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).keys).to match_array(['teacher'])
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

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).keys).to match_array(['teacher'])
      end

      it 'Returns HTTP success if use -admin_session-' do
        headers = { 'Authorization': 'Bearer ' + admin_session.token }
        request.headers.merge! headers
        get :last, format: :json

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).keys).to match_array(['teacher'])
      end
    end

    context 'GET #appointments for Teacher with ID = teacher_last_id' do
      it 'Returns HTTP unauthorized if do not use a session' do
        get :appointments, params: { id: teacher_last_id }, format: :json

        expect(response).to have_http_status(:unauthorized)
      end

      it 'Returns HTTP success if use -not_admin_session-' do
        headers = { 'Authorization': 'Bearer ' + not_admin_session.token }
        request.headers.merge! headers
        get :appointments, params: { id: teacher_last_id }, format: :json

        expect(response).to have_http_status(:forbidden)
      end

      it 'Returns HTTP success if use -admin_session-' do
        headers = { 'Authorization': 'Bearer ' + admin_session.token }
        request.headers.merge! headers
        get :appointments, params: { id: teacher_last_id }, format: :json

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).keys).to match_array(['appointments'])
      end
    end

    context 'GET #availability for Teacher with ID = teacher_last_id' do
      it 'Returns HTTP unauthorized if do not use a session' do
        get :availability, params: { id: teacher_last_id, date: date_for_testing_appointments }, format: :json

        expect(response).to have_http_status(:unauthorized)
      end

      it 'Returns HTTP success if use -not_admin_session-' do
        headers = { 'Authorization': 'Bearer ' + not_admin_session.token }
        request.headers.merge! headers
        get :availability, params: { id: teacher_last_id, date: date_for_testing_appointments }, format: :json

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).keys).to match_array(['teacher'])
      end

      it 'Returns HTTP success if use -admin_session-' do
        headers = { 'Authorization': 'Bearer ' + admin_session.token }
        request.headers.merge! headers
        get :availability, params: { id: teacher_last_id, date: date_for_testing_appointments }, format: :json

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).keys).to match_array(['teacher'])
      end
    end

    context 'POST #create' do
      it 'Returns HTTP unauthorized if do not use a session' do
        post :create,
             params: { teacher: {
               fullname: 'Another Good Teacher',
               email: 'another@xmail.xyz',
               photo: 'https://localhost:8080/image99.png',
               course: 'Nobody interesting',
               description: 'All topics are really funny'
             } },
             format: :json

        expect(response).to have_http_status(:unauthorized)
      end

      it 'Returns HTTP forbidden if use -not_admin_session-' do
        headers = { 'Authorization': 'Bearer ' + not_admin_session.token }
        request.headers.merge! headers
        post :create,
             params: { teacher: {
               fullname: 'Another Good Teacher',
               email: 'another@xmail.xyz',
               photo: 'https://localhost:8080/image99.png',
               course: 'Nobody interesting',
               description: 'All topics are really funny'
             } },
             format: :json

        expect(response).to have_http_status(:forbidden)
      end

      it 'Returns HTTP success if use -admin_session-' do
        headers = { 'Authorization': 'Bearer ' + admin_session.token }
        request.headers.merge! headers
        post :create,
             params: { teacher: {
               fullname: 'Another Good Teacher',
               email: 'another@xmail.xyz',
               photo: 'https://localhost:8080/image99.png',
               course: 'Nobody interesting',
               description: 'All topics are really funny'
             } },
             format: :json

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).keys).to match_array(['teacher'])
      end
    end

    context 'PUT #update for Teacher with ID = 3' do
      it 'Returns HTTP unauthorized if do not use a session' do
        put :update,
            params: { id: teacher_last_id, teacher: {
              fullname: 'Another Bad Teacher',
              email: 'another@xmail.xyz',
              course: 'Nobody interesting'
            } },
            format: :json

        expect(response).to have_http_status(:unauthorized)
      end

      it 'Returns HTTP forbidden if use -not_admin_session-' do
        headers = { 'Authorization': 'Bearer ' + not_admin_session.token }
        request.headers.merge! headers
        put :update,
            params: { id: teacher_last_id, teacher: {
              fullname: 'Another Bad Teacher',
              email: 'another@xmail.xyz',
              course: 'Nobody interesting'
            } },
            format: :json

        expect(response).to have_http_status(:forbidden)
      end

      it 'Returns HTTP success if use -admin_session-' do
        headers = { 'Authorization': 'Bearer ' + admin_session.token }
        request.headers.merge! headers
        put :update,
            params: { id: teacher_last_id, teacher: {
              fullname: 'Another Bad Teacher',
              email: 'another@xmail.xyz',
              course: 'Nobody interesting'
            } },
            format: :json

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).keys).to match_array(['teacher'])
      end
    end

    context 'DELETE #destroy' do
      it 'Returns HTTP unauthorized if do not use a session' do
        delete :destroy, params: { id: teacher_last_id }, format: :json

        expect(response).to have_http_status(:unauthorized)
      end

      it 'Returns HTTP forbidden if use -not_admin_session-' do
        headers = { 'Authorization': 'Bearer ' + not_admin_session.token }
        request.headers.merge! headers
        delete :destroy, params: { id: teacher_last_id }, format: :json

        expect(response).to have_http_status(:forbidden)
      end

      it 'Returns HTTP success if use -admin_session-' do
        headers = { 'Authorization': 'Bearer ' + admin_session.token }
        request.headers.merge! headers
        delete :destroy, params: { id: teacher_last_id }, format: :json

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).keys).to match_array(['teacher'])
      end
    end
  end
end
# rubocop: enable Metrics/BlockLength
