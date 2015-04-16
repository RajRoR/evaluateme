# Initializer file of the plugin.

require "evaluateme/engine"

module Evaluateme

  # Secret key.
  mattr_accessor :secret_key
  @@secret_key = "evaluateme321"

  mattr_accessor :parent_controller
  @@parent_controller = "ApplicationController"

  mattr_accessor :mailer_sender
  @@mailer_sender = 'admin@evaluateme.com' 

  def self.setup
    yield self
  end

end
