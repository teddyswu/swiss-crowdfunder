aws = YAML.load_file("config/aws.yml")[Rails.env]

ActionMailer::Base.add_delivery_method :ses, AWS::SES::Base,
  :access_key_id     => aws[:access_key_id],
  :secret_access_key => aws[:secret_access_key]