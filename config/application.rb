require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TravelWeb
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    # Bower asset paths
    root.join('vendor', 'assets', 'bower_components').to_s.tap do |bower_path|
      config.sass.load_paths << bower_path
      config.assets.paths << bower_path
    end

    # Precompile Bootstrap fonts
    config.assets.precompile << %r(bootstrap-sass/assets/fonts/bootstrap/[\w-]+\.(?:eot|svg|ttf|woff2?)$)
    config.assets.precompile << %r(slick-carousel/slick/fonts/[\w-]+\.(?:eot|svg|ttf|woff?)$)
    # config.assets.precompile << Proc.new { |path|
    #   if path =~ /\.(coffee|erb|js|scss)\z/
    #     full_path = Rails.application.config.assets.resolve(path)
    #     app_assets_path = Rails.root.join('app', 'assets').to_path
    #     if full_path.starts_with? app_assets_path
    #       # puts "including asset: " + full_path
    #       true
    #     else
    #       # puts "excluding asset: " + full_path
    #       false
    #     end
    #   else
    #     false
    #   end
    # }
    # Minimum Sass number precision required by bootstrap-sass
    ::Sass::Script::Value::Number.precision = [8, ::Sass::Script::Value::Number.precision].max

    # Serving statics files like images uploaded by carrierwave
    config.public_file_server.enabled = true
  end
end
