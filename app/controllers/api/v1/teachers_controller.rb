class Api::V1::TeachersController < ApplicationController
  before_action :doorkeeper_authorize!
  before_action :set_teacher, only: %i[show update destroy availability appointments]
  before_action :set_teachers, only: %i[index]
  before_action :set_last_teacher, only: %i[last]

  # GET /teachers
  api :GET, '/teachers', 'For listing'
  def index
    render :index
  end

  # GET /teachers/1
  api :GET, '/teachers/:id', 'For listing'
  def show
    render :show
  end

  # GET /teachers/last
  api :GET, '/teachers/last', 'For listing'
  def last
    render :show
  end

  # GET /teachers/1/availability/2020-01-01
  api :GET, '/teachers/:id/availability/:date', 'For listing'
  def availability
    if params[:date].to_date > Time.now.utc.to_date
      @appointments = Appointment
        .where('teacher_id = ? AND scheduled_for BETWEEN ? AND ?',
               @teacher.id,
               params[:date].to_date,
               params[:date].to_date.next_day(1))

      @availability = {
        'teacher' => {
          'id' => @teacher.id,
          'availability' => ((8..12).to_a | (14..19).to_a) - @appointments.map { |item| item.scheduled_for.hour }.to_a
        }
      }
    else
      @availability = {
        'teacher' => {
          'id' => @teacher.id,
          'availability' => []
        }
      }
    end

    render json: @availability
  end

  # GET /teachers/1/appointments
  api :GET, '/teachers/:id/appointments', 'For listing'  
  def appointments
    if admin_permission?
      @appointments = Appointment
        .select(:id,
                :scheduled_for,
                'users.fullname as user_fullname',
                'users.email as user_email',
                'CASE WHEN scheduled_for > timezone(\'utc\', now()) THEN 1 ELSE 0 END as status')
        .joins(:user)
        .where(teacher_id: @teacher.id)
        .order(scheduled_for: :asc)

      render :appointments
    else
      render json: return_error_message(403), status: :forbidden
    end
  end

  # POST /teachers
  api :POST, '/teachers', 'For creating'
  def create
    if admin_permission?
      @teacher = Teacher.new(teacher_params)
      if @teacher.save
        render :show, status: :created
      else
        render json: @teacher.errors, status: :unprocessable_entity
      end
    else
      render json: return_error_message(403), status: :forbidden
    end
  end

  # PATCH/PUT /teachers/1
  api :PUT, '/teachers/:id', 'For updating'
  def update
    if admin_permission?
      if @teacher.update(teacher_params)
        render :show
      else
        render json: @teacher.errors, status: :unprocessable_entity
      end
    else
      render json: return_error_message(403), status: :forbidden
    end
  end

  # DELETE /teachers/1
  api :DELETE, '/teachers/:id', 'For removing'
  def destroy
    if admin_permission?
      Appointment.where(teacher_id: @teacher.id).destroy_all
      @teacher.destroy

      render :show
    else
      render json: return_error_message(403), status: :forbidden
    end
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
