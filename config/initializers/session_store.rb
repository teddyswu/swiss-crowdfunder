custom = YAML.load_file("config/settings.yml")
Crowdfunding::Application.config.session_store :cookie_store, key: '_ugooz_session', domain: custom[:domain]