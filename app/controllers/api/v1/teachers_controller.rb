class Api::V1::TeachersController < ApplicationController
  before_action :doorkeeper_authorize!
  before_action :set_teacher, only: %i[show update destroy availability appointments]
  before_action :set_teachers, only: %i[index]
  before_action :set_last_teacher, only: %i[last]
  before_action :admin_permission?, only: %i[appointments create update destroy]

  include TeachersDoc

  # GET /teachers
  def index
    render :index
  end

  # GET /teachers/1
  def show
    render :show
  end

  # GET /teachers/last
  def last
    render :show
  end

  # GET /teachers/1/availability/2020-01-01
  def availability
    @availability = @teacher.availability(params[:date])
    render :availability
  end

  # GET /teachers/1/appointments
  def appointments
    @appointments = @teacher.appointments_scheduled
    render :appointments
  end

  # POST /teachers
  def create
    @teacher = Teacher.new(teacher_params)
    if @teacher.save
      render :show, status: :created
    else
      render json: @teacher.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /teachers/1
  def update
    if @teacher.update(teacher_params)
      render :show
    else
      render json: @teacher.errors, status: :unprocessable_entity
    end
  end

  # DELETE /teachers/1
  def destroy
    Appointment.where(teacher_id: @teacher.id).destroy_all
    @teacher.destroy

    render :show
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_last_teacher
    @teacher = Teacher.last
  end

  def set_teacher
    @teacher = Teacher.find(params[:id])
  end

  def set_teachers
    @teachers = Teacher.all.order(:fullname)
  end

  # Only allow a trusted parameter "white list" through.
  def teacher_params
    params.require(:teacher).permit(:fullname, :email, :photo, :course, :description)
  end
end
