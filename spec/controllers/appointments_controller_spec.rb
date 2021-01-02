# rubocop: disable Metrics/BlockLength
require 'rails_helper'

RSpec.describe Api::V1::AppointmentsController do
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

  describe 'Tests for TEACHERS controller' do
    let(:teacher_last_id) { Teacher.last.id }
    let(:user_first_id) { User.first.id }
    let(:user_last_id) { User.last.id }
    let(:appointment_first_id) { Appointment.first.id }

    let(:admin_session) { Doorkeeper::AccessToken.create!(resource_owner_id: user_first_id, expires_in: 1.hours) }
    let(:not_admin_session) { Doorkeeper::AccessToken.create!(resource_owner_id: user_last_id, expires_in: 1.hours) }
    let(:date_for_testing_appointments) { Time.now.utc.next_day(1).to_s[0..9] }
    let(:invalid_date_for_testing_appointments) { Time.now.utc.next_day(-10).to_s[0..9] }

    render_views

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
        expect(JSON.parse(response.body).keys).to match_array(['appointment'])
      end

      it 'Returns HTTP success if use -admin_session-' do
        headers = { 'Authorization': 'Bearer ' + admin_session.token }
        request.headers.merge! headers
        get :last, format: :json

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).keys).to match_array(['appointment'])
      end
    end

    context 'POST #create an appointment with Teacher ID = 2' do
      it 'Returns HTTP unauthorized if do not use a session' do
        post :create,
             params: { appointment: {
               scheduled_for: date_for_testing_appointments,
               teacher_id: teacher_last_id
             } },
             format: :json

        expect(response).to have_http_status(:unauthorized)
      end

      it 'Returns HTTP forbidden if use -not_admin_session-' do
        headers = { 'Authorization': 'Bearer ' + not_admin_session.token }
        request.headers.merge! headers
        post :create,
             params: { appointment: {
               scheduled_for: date_for_testing_appointments,
               teacher_id: teacher_last_id
             } },
             format: :json

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).keys).to match_array(['appointment'])
      end

      it 'Returns HTTP success if use -admin_session-' do
        headers = { 'Authorization': 'Bearer ' + admin_session.token }
        request.headers.merge! headers
        post :create,
             params: { appointment: {
               scheduled_for: date_for_testing_appointments,
               teacher_id: teacher_last_id
             } },
             format: :json

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).keys).to match_array(['appointment'])
      end 
    end

    context 'DELETE #destroy' do
      it 'Returns HTTP unauthorized if do not use a session' do
        delete :destroy, params: { id: appointment_first_id }, format: :json

        expect(response).to have_http_status(:unauthorized)
      end

      it 'Returns HTTP forbidden if use -not_admin_session- for removing an appointment that not belongs him/her' do
        headers = { 'Authorization': 'Bearer ' + not_admin_session.token }
        request.headers.merge! headers
        delete :destroy, params: { id: appointment_first_id }, format: :json

        expect(response).to have_http_status(:forbidden)
      end

      it 'Returns HTTP success if use -not_admin_session- for removing an appointment that belongs him/her' do
        headers = { 'Authorization': 'Bearer ' + admin_session.token }
        request.headers.merge! headers
        delete :destroy, params: { id: appointment_first_id }, format: :json

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).keys).to match_array(['appointment'])
      end

      it 'Returns HTTP success if use -admin_session-' do
        headers = { 'Authorization': 'Bearer ' + admin_session.token }
        request.headers.merge! headers
        delete :destroy, params: { id: appointment_first_id }, format: :json

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).keys).to match_array(['appointment'])
      end
    end
  end
end
# rubocop: enable Metrics/BlockLength
