class Api::V1::CloudinaryController < ApplicationController
  # GET /cloudinary
  def index
    @upload_preset = { 'cloud_name' => 'mt4yammy58c7cu2r5u9u8acwuqeyuy79', 'upload_preset' => '2q4gaah5pzg6bpany8j6pmjcxy5amqfcjq976ce93rfttupa65drd8j4qdjzgmy4' }
    render json: @upload_preset
  end
end
