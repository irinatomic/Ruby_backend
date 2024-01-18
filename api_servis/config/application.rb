require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module WebFlowerShopApi
  class Application < Rails::Application

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    config.autoload_lib(ignore: %w(assets tasks))

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    # Add custome folder to autoload paths
    config.autoload_paths << Rails.root.join('app/services')
  end
end
