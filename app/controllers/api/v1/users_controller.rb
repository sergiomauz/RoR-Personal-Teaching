class Api::V1::UsersController < ApplicationController
  before_action :doorkeeper_authorize!, except: %i[create]
  before_action :set_user, only: %i[show update destroy]
  before_action :set_users, only: %i[index]
  before_action :set_last_user, only: %i[last]

  # POST /users
  api :POST, '/users', 'Create an user'
  param :user, Hash do
    param :email, String, desc: 'Username for login', required: true
    param :fullname, String
    param :password, String
    param :username, String
  end
  def create
    @user = User.new(user_params)

    if @user.save
      render :show, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # GET /users/myprofile
  api :GET, '/users/myprofile'
  error code: 401
  def myprofile
    render :myprofile
  end

  # GET /users
  api :GET, '/users', 'List users'
  error code: 401
  error code: 403
  def index
    if admin_permission?
      render :index
    else
      render json: return_error_message(403), status: :forbidden
    end
  end

  # GET /users/1
  api :GET, '/users/:id', 'Show an user'
  error code: 401
  error code: 403
  def show
    if admin_permission?
      render :show
    else
      render json: return_error_message(403), status: :forbidden
    end
  end

  # GET /users/last
  api :GET, '/users/last'
  error code: 401
  error code: 403
  def last
    if admin_permission?
      render :show
    else
      render json: return_error_message(403), status: :forbidden
    end
  end

  # PATCH/PUT /users/1
  api :PATCH, '/users/:id', 'Update an user'
  api :PUT, '/users/:id', 'Update an user'
  param :user, Hash do
    param :email, :undef
    param :fullname, :undef
    param :password, :undef
    param :username, :undef
  end
  error code: 401
  error code: 403
  def update
    if admin_permission?
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
  api :DELETE, '/users/:id', 'Destroy an user'
  error code: 401
  error code: 403
  def destroy
    if admin_permission?
      Appointment.where(user_id: @user.id).destroy_all
      @user.destroy

      render :show
    else
      render json: return_error_message(403), status: :forbidden
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_last_user
    @user = User.last
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_users
    @users = User.all.order(:fullname)
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:fullname, :email, :username, :password)
  end
end
