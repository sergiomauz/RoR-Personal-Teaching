class Api::V1::TeachersController < ApplicationController
  before_action :doorkeeper_authorize!
  before_action :set_teacher, only: %i[show update destroy]

  # GET /teachers
  def index
    @teachers = Teacher.all

    render json: @teachers
  end

  # GET /teachers/1
  def show
    render :show
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
