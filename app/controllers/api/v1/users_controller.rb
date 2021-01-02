class Api::V1::UsersController < ApplicationController
  before_action :doorkeeper_authorize!, except: %i[create]
  before_action :set_user, only: %i[show update destroy]
  before_action :set_users, only: %i[index]
  before_action :set_last_user, only: %i[last]
  before_action :set_current_user, only: %i[myprofile myappointments]
  before_action :admin_permission?, only: %i[index show last update destroy]

  include UsersDoc

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render :show, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # GET /users/myprofile
  def myprofile
    render :myprofile
  end

  # GET /users/myappointments
  def myappointments
    @appointments = @user.my_appointments
    render :appointments
  end

  # GET /users
  def index
    render :index
  end

  # GET /users/1
  def show
    render :show
  end

  # GET /users/last
  def last
    render :show
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render :show
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    Appointment.where(user_id: @user.id).destroy_all
    @user.destroy

    render :show
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_last_user
    @user = User.last
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_current_user
    @user = current_user
  end

  def set_users
    @users = User.all.order(:fullname)
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:fullname, :email, :username, :password)
  end
end
