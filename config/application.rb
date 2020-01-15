require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TuningMV
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # タイムゾーンを東京にする
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local

    # デフォルトのlocaleを日本語にする
    config.i18n.default_locale = :ja

    # 複数のロケールファイルを読み込むようにする
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]

    # Rspecで不要なspecファイルを作成しないようにする
    config.generators do |g|
      g.test_framework :rspec,
        fixtures: false,
        view_specs: false,
        helper_specs: false,
        routing_specs: false
    end
  end
end
