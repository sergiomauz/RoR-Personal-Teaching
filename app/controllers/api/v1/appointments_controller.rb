class Api::V1::AppointmentsController < ApplicationController
  before_action :doorkeeper_authorize!
  before_action :set_current_user
  before_action :set_appointment, only: %i[destroy]
  before_action :admin_or_owner_auth, only: %i[destroy]
  before_action :set_last_appointment, only: %i[last]

  include AppointmentsDoc

  # GET /appointments/last
  def last
    render :show
  end

  # POST /appointments
  def create
    @new_appointment = Appointment.new(appointment_params)    
    @new_appointment.user_id = @current_user.id

    if @new_appointment.save
      @appointment = Appointment.detailed_info(@new_appointment.id)

      render :detailed, status: :created
    else
      render json: @new_appointment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /appointments/1
  def destroy
    @appointment.destroy
    render :show
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

  def admin_or_owner_auth
    return if current_user.admin || @appointment.user_id == current_user.id

    render json: return_error_message(403), status: :forbidden
  end

  # Only allow a list of trusted parameters through.
  def appointment_params
    params.require(:appointment).permit(:scheduled_for, :teacher_id)
  end
end
