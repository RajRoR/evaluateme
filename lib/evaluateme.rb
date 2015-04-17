# Initializer file of the 'evaluateme'.

require "evaluateme/engine"
module Evaluateme

  # Secret key.
  mattr_accessor :secret_key
  @@secret_key = "evaluateme321"

  # Using a Controller Provided by the Application.
  mattr_accessor :parent_controller
  @@parent_controller = "ApplicationController"

  # Set the email for the mailer_sender.
  mattr_accessor :mailer_sender
  @@mailer_sender = 'admin@example.com' 

  def self.setup
    yield self
  end

end
