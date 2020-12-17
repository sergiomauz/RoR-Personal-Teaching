class Api::V1::CloudinaryController < ApplicationController
  before_action :doorkeeper_authorize!

  # GET /cloudinary
  def index
    if admin_permission?
      @upload_preset = {
        'cloud_name' => 'mt4yammy58c7cu2r5u9u8acwuqeyuy79',
        'upload_preset' => '2q4gaah5pzg6bpany8j6pmjcxy5amqfcjq976ce93rfttupa65drd8j4qdjzgmy4'
      }

      render json: @upload_preset
    else
      render json: return_error_message(403), status: :forbidden
    end
  end
end
