class Api::V1::AppointmentsController < ApplicationController
  before_action :doorkeeper_authorize!
  before_action :set_appointment, only: %i[show destroy]

  # GET /appointments
  def index
    @current_user = current_user
    if @current_user
      @appointments = Appointment
        .select(:id, :scheduled_for, 'teachers.fullname as teacher_fullname', :'teachers.course', 'CASE WHEN scheduled_for > timezone(\'utc\', now()) THEN 1 ELSE 0 END as status')
        .joins(:teacher).where(user_id: @current_user.id)
        .order(scheduled_for: :asc)

      render json: @appointments
    end
  end

  # GET /appointments/1
  def show
    render :show
  end

  # POST /appointments
  def create
    @current_user = current_user
    @appointment = Appointment.new(appointment_params)

    @appointment.user_id = @current_user.id

    if @appointment.save
      render json: @appointment, status: :created
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /appointments/1
  def destroy
    @appointment.destroy

    render json: @appointment
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def appointment_params
    params.require(:appointment).permit(:scheduled_for, :teacher_id)
  end
end
