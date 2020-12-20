class Api::V1::CloudinaryController < ApplicationController
  before_action :doorkeeper_authorize!

  # GET /cloudinary
  api :GET, '/cloudinary', 'For requesting Key'
  def index
    if admin_permission?
      @upload_preset = {
        'cloud_name' => Rails.configuration.x.cloudinary.cloud_name,
        'upload_preset' => Rails.configuration.x.cloudinary.upload_preset
      }

      render json: @upload_preset
    else
      render json: return_error_message(403), status: :forbidden
    end
  end
end
