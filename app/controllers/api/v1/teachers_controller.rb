class Api::V1::TeachersController < ApplicationController
  # before_action :doorkeeper_authorize!
  before_action :set_teacher, only: %i[show update destroy availability]

  # GET /teachers
  def index
    @teachers = Teacher.all

    render json: @teachers
  end

  # GET /teachers/1
  def show
    render :show
  end

  # GET /teacher/1/availability/2020-01-01
  def availability
    @appointments = Appointment.where('teacher_id = ? AND scheduled_for BETWEEN ? AND ?', @teacher.id, params[:date].to_date, params[:date].to_date.next_day(1))

    @availability = { 'availability' => (8..19).to_a - @appointments.map { |item| item.scheduled_for.hour }.to_a }

    render json: @availability
  end

  # POST /teachers
  def create
    @teacher = Teacher.new(teacher_params)

    if @teacher.save
      render json: @teacher, status: :created
    else
      render json: @teacher.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /teachers/1
  def update
    if @teacher.update(teacher_params)
      render json: @teacher
    else
      render json: @teacher.errors, status: :unprocessable_entity
    end
  end

  # DELETE /teachers/1
  def destroy
    Appointment.where(teacher_id: @teacher.id).destroy_all
    @teacher.destroy

    render json: @teacher
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_teacher
    @teacher = Teacher.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def teacher_params
    params.require(:teacher).permit(:fullname, :email, :photo, :course, :description)
  end
end
