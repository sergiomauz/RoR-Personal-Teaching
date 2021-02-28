json.cloudinary_config do
  json.cloud_name Rails.configuration.x.cloudinary.cloud_name
  json.upload_preset Rails.configuration.x.cloudinary.upload_preset
end
