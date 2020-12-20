require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BackendPersonalTeaching
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.x.cloudinary.cloud_name = 'mt4yammy58c7cu2r5u9u8acwuqeyuy79'
    config.x.cloudinary.upload_preset = '2q4gaah5pzg6bpany8j6pmjcxy5amqfcjq976ce93rfttupa65drd8j4qdjzgmy4'
  end
end
