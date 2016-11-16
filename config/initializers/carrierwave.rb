if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'Google',
      google_storage_access_key_id: Rails.application.secrets.gg_storage_access_key,
      google_storage_secret_access_key: Rails.application.secrets.gg_storage_secret_key
    }
    config.fog_directory = 'greenmile-149706.appspot.com'
  end
end
