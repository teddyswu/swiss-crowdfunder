class SelfConfig

  # attr_accessor :config

  # def initialize
    @@config = YAML.load_file("config/settings.yml")
    # config2 = YAML.load(File.open("config/settings.local.yml")) || {}

    # @config = config1.merge(config2)
  # end

  def self.agrisc_host
  	@@config[:agrisc_host]
  end

  def self.upload_dir
    @@config[:upload_dir]
  end

  def self.root_host
    @@config[:root_host]
  end

end
