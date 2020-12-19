class Api::V1::AppointmentsController < ApplicationController
  before_action :doorkeeper_authorize!
  before_action :set_appointment, only: %i[destroy]
  before_action :set_current_user, only: %i[index create last]
  before_action :set_last_appointment, only: %i[last]

  # GET /appointments
  def index
    if @current_user
      @appointments = Appointment
        .select(:id,
                :scheduled_for,
                'teachers.fullname as teacher_fullname',
                'teachers.course',
                'CASE WHEN scheduled_for > timezone(\'utc\', now()) THEN 1 ELSE 0 END as status')
        .joins(:teacher)
        .where(user_id: @current_user.id)
        .order(scheduled_for: :asc)

      render :index
    else
      render json: return_error_message(403), status: :forbidden
    end
  end

  # GET /appointments/last
  def last
    render :show
  end

  # POST /appointments
  def create
    @new_appointment = Appointment.new(appointment_params)
    @new_appointment.user_id = @current_user.id

    if @new_appointment.scheduled_for > Time.now.utc
      if @new_appointment.save
        @appointment = Appointment
          .select(:id,
                  :scheduled_for,
                  'teachers.fullname as teacher_fullname',
                  'teachers.course',
                  'CASE WHEN scheduled_for > timezone(\'utc\', now()) THEN 1 ELSE 0 END as status')
          .joins(:teacher)
          .where(id: @new_appointment.id)
          .first

        render json: { 'appointment' => @appointment }, status: :created
      else
        render json: @new_appointment.errors, status: :unprocessable_entity
      end
    else
      render json: return_error_message(403), status: :forbidden
    end
  end

  # DELETE /appointments/1
  def destroy
    if admin_permission? || @appointment.user_id == current_user.id
      @appointment.destroy
      render :show
    else
      render json: return_error_message(403), status: :forbidden
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_last_appointment
    @appointment = Appointment.where(user_id: @current_user.id).last
  end

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def set_current_user
    @current_user = current_user
  end

  # Only allow a list of trusted parameters through.
  def appointment_params
    params.require(:appointment).permit(:scheduled_for, :teacher_id)
  end
end
