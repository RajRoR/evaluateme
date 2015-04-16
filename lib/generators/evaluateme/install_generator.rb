require 'rails/generators/base'

module Evaluateme
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)
      desc "Creates a Evaluateme initializer and add routes for the plugin"

      # Copy the initializer file to the hooked application.
      def copy_initializer
        template "evaluateme.rb", "config/initializers/evaluateme.rb"
        puts "Initializers file of plugin has copied."
      end

      # Add the routes in the hooked application for mounting the plugin.
      def add_plugin_routes
        plugin_route  =  "mount Evaluateme::Engine => '/evaluateme'"
        target  = "config/routes.rb"
        routes_defined = false
        # Check the routes for plugin already exists in hooked application?
        File.open(target, 'r+') do |f|
          f.each do |line|
            routes_defined = true if line.include? plugin_route
          end
        end
        # Write the routes path if not set.
        unless routes_defined
          route plugin_route
        end
        puts "Routes have defined for the plugin"
      end

      # Set stylesheets and javascript in assets.rb
      def add_assets_path
        css_data = "Rails.application.config.assets.precompile += %w( amelia.css )"
        js_data = "Rails.application.config.assets.precompile += %w( amelia.js )" 
        set_css_path = set_js_path = false

        target  = "config/initializers/assets.rb"

        # Check the path if already exists?
        File.open(target, 'r+') do |f|
          f.each do |line|
            set_css_path = true if line.include? css_data
            set_js_path = true if line.include? js_data
          end
    
          # Write into assets.rb
          f.write css_data + "\n" unless set_css_path
          f.write js_data + "\n" unless set_js_path
        end
        puts "Assets have defined for the plugin theme"
      end

     # Instal migrations of the plugin.
      # def install_migrations 
        # Rake::Task["install:migrations"].invoke
        # puts "Migrations have run"
      # end
    end
  end
end