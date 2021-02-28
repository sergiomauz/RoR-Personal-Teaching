class Api::V1::CloudinaryController < ApplicationController
  before_action :doorkeeper_authorize!
  before_action :admin_permission?, only: %i[index]

  include CloudinaryDoc

  # GET /cloudinary
  def index
    render :index
  end
end
