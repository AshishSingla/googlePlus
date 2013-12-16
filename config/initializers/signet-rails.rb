
APP_CONFIG = YAML.load_file("#{Rails.root}/config/app_plus.yml")

Signet::Rails::Builder.set_default_options client_id: "456182194859-d899g389ufasnnt23kdfgsg3nqtu4aa6.apps.googleusercontent.com",
  client_secret: "C-hDNAd6Eo4F2k1uhkrztvGV"

Rails.application.config.middleware.use Signet::Rails::Builder do 
  provider name: :google, 
    type: :login,
    scope: [
            'https://www.googleapis.com/auth/plus.me',
            'https://www.googleapis.com/auth/plus.media.upload',
            'https://www.googleapis.com/auth/plus.profiles.read',
            'https://www.googleapis.com/auth/plus.stream.read',
            'https://www.googleapis.com/auth/plus.stream.write',
            'https://www.googleapis.com/auth/plus.circles.read',
            'https://www.googleapis.com/auth/plus.circles.write',
            'https://www.googleapis.com/auth/userinfo.email',
            'https://www.googleapis.com/auth/userinfo.profile'
  ]
end