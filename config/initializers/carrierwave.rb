puts "test #{ENV['FP_LOCATION']}"
key = ENV["S3_KEY"]
key ||= Rails.application.secrets.S3_KEY
secret = ENV["S3_SECRET"]
secret ||= Rails.application.secrets.S3_SECRET
CarrierWave.configure do |config|
  config.enable_processing = true
  config.directory_permissions = 0777
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => key,
    :aws_secret_access_key  => secret
  }
   
  config.fog_directory  = 'forbiddenplanet-assets'                          # required
  config.fog_public     = false                                        # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>"max-age=#{365.day.to_i}"} # optional, defaults to {}
end

