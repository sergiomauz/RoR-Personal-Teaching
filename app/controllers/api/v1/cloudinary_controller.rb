class Api::V1::CloudinaryController < ApplicationController
  # GET /cloudinary
  def index
    @upload_preset = { 'cloud_name' => 'sergiouce16', 'upload_preset' => '5tf4a2fgjtvqsjk7bh49zybdbw6tjhze' }
    render json: @upload_preset
  end
end
