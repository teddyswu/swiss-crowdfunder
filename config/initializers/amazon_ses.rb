aws = YAML.load_file("config/aws.yml")[Rails.env]

ActionMailer::Base.add_delivery_method :ses, AWS::SES::Base,
  :access_key_id     => aws[:mail_key_id],
  :secret_access_key => aws[:mail_access_key]