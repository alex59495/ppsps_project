require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PpspsProject
  class Application < Rails::Application
    # Autorize to rewrite the errors page
    config.exceptions_app = self.routes

    # Define the path for the video
    config.assets.paths << "#{Rails.root}/app/assets/videos"

    config.assets.enabled = true

    config.generators do |generate|
      # generate.assets false
      # generate.helper false
      generate.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: true,
        request_specs: true
      generate.fixture_replacement :factory_bot, dir: "spec/factories"
    end
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Change dafault i18n value
    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
    config.i18n.default_locale = :fr
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
