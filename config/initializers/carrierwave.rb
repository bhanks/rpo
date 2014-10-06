CarrierWave.configure do |config|
  config.enable_processing = true
  config.directory_permissions = 0777
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => ENV['S3_KEY'],
    :aws_secret_access_key  => ENV['S3_SECRET'],                        # required
  }
  config.fog_directory  = 'forbiddenplanet-assets'                          # required
  config.fog_public     = false                                        # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>"max-age=#{365.day.to_i}"} # optional, defaults to {}
end

