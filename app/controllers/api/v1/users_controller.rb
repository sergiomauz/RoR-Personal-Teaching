class Api::V1::UsersController < ApplicationController
  before_action :doorkeeper_authorize!, except: %i[create]
  before_action :set_user, only: %i[show update destroy]
  before_action :set_users, only: %i[index]
  before_action :set_current_user, only: %i[index show update destroy]

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

  # GET /users
  def index
    if @current_user.admin
      render :index
    else
      render json: return_error_message(403), status: :forbidden
    end
  end

  # GET /users/1
  def show
    if @current_user.admin
      render :show
    else
      render json: return_error_message(403), status: :forbidden
    end
  end

  # PATCH/PUT /users/1
  def update
    if @current_user.admin
      if @user.update(user_params)
        render :show
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    else
      render json: return_error_message(403), status: :forbidden
    end
  end

  # DELETE /users/1
  def destroy
    if @current_user.admin
      Appointment.where(user_id: @user.id).destroy_all
      @user.destroy
      render :show
    else
      render json: return_error_message(403), status: :forbidden
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def set_users
    @users = User.all
  end

  def set_current_user
    @current_user = current_user
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:fullname, :email, :username, :password)
  end
end
