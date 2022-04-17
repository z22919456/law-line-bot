require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LineBot
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.i18n.load_path += Dir[
      File.join(Rails.root, 'config', 'locales', '**', '*.{rb,yml}'),
      File.join(Rails.root, 'config', 'locales', 'models', '**', '*.{rb,yml}')
    ]

    config.time_zone = 'Taipei'
    # config.i18n.default_locale = :"zh-TW"
    config.i18n.locale = :"zh-TW"

    config.assets.initialize_on_precompile = false

    # config.autoload_paths += Dir[Rails.root.join('app/models/history/')]

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end

Webpacker::Compiler.env['TAILWIND_MODE'] = 'build'
