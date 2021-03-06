require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Crowdfunding
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.eager_load_paths += Dir["#{config.root}/lib"] # 載入lib/底下所有.rb的檔案
    config.eager_load_paths += Dir["#{config.root}/lib/module/**/"] # 載入lib/module/底下所有.rb的檔案
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.exceptions_app = self.routes
    config.time_zone = 'Asia/Taipei'
    config.active_job.queue_adapter = :delayed_job
    
  end
end
