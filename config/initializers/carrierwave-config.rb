# -*- encoding : utf-8 -*-
# Fog.credentials_path = Rails.root.join("config/aws.yml")

CarrierWave.configure do |config|
  aws = YAML.load_file("config/aws.yml")[Rails.env]
  config.fog_credentials = {
    :provider               => 'AWS',                     # required
    :aws_access_key_id      => aws[:access_key_id],       # required
    :aws_secret_access_key  => aws[:secret_access_key],   # required
    :region                 => aws[:s3_region]
  }
  
  config.fog_directory  = aws[:s3_bucket_name]
  config.asset_host     = aws[:s3_host_name]              # 3.2.6 原 config.fog_host
  config.fog_public     = true                            # optional, defaults to true
  config.fog_attributes = {'x-amz-storage-class' => 'REDUCED_REDUNDANCY'}
end
