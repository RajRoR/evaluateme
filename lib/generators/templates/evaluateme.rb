# Use this hook to configure plugin.
# Many of these configuration options can be set straight in your model.

Evaluateme.setup do |config|
  # The secret key used by Plugin. 
  config.secret_key = '0d8b334c23721ab4d14deb772cd14729f378d15dce9cdb6822db0bf6ab84bb1509c5b1a668cbfe4f5d1b063d04686cc0b285aa2772438b5cc1a0c2c403f0af6d'

  # ==> Mailer Configuration
  # Configure the e-mail address which will be shown in Evaluateme::Mailer,
  config.mailer_sender = 'admin@evaluateme.com'
end
