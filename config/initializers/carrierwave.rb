require 'carrierwave/storage/fog'

if Rails.env.production?
  config.storage = :fog
  config.fog_provider= 'fog/aws'
  CarrierWave.configure do |config|
    config.fog_directory     =  ENV['S3_BUCKET']
    config.fog_credentials = {
      # Configuration for Amazon S3
      :provider              => 'AWS',
      :aws_access_key_id     => ENV['S3_ACCESS_KEY'],
      :aws_secret_access_key => ENV['S3_SECRET_KEY']
    }
  end
end
