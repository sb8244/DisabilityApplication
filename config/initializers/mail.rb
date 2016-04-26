DisabilityApp::Application.configure do
  ActionMailer::Base.smtp_settings = {
    :address   => ENV.fetch("SMTP_ADDRESS"),
    :port      => ENV.fetch("SMTP_PORT", 25),
    :domain => 'ada.cs.ship.edu' # your domain to identify your server when connecting
  }
end
