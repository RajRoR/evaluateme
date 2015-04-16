# Rake tasks to set the routes, assets, install migrations and create initializer file.

desc "Setting all the required configuration for the plugin in the application"

namespace :evaluateme do

  task :install do
    Rake::Task["evaluateme:set_routes"].invoke
    Rake::Task["evaluateme:set_assets_path"].invoke
    Rake::Task["evaluateme:install_migrations"].invoke
    Rake::Task["evaluateme:initializer_file"].invoke
  end

  # Set routes path for the plugin
  task :set_routes do
    target  = "config/routes.rb"
    set_routes_plugin = "mount Evaluateme::Engine => '/evaluateme'"
    routes_defined = false
  
    # Check the routes line of plugin already exists?
    File.open(target, 'r+') do |f|
      f.each do |line|
        routes_defined = true if line.include? set_routes_plugin
      end

      # Write the routes path if not already set.
      unless routes_defined
        f.rewind
        f.each do |line|
          break  if line.include? "Rails.application.routes.draw do"
        end
        pos = f.pos                     # save your position in the file
        rest_data = f.read                   # save the rest of the file
        f.seek pos                      # go back to the old position
        f.write set_routes_plugin + "\n"
        f.write rest_data            # write new data & rest of file
      end
      puts "Routes are defined for the plugin "
    end
  end

  # Set stylesheets and javascript in assets.rb
  task :set_assets_path do
    target  = "config/initializers/assets.rb"
    css_data = "Rails.application.config.assets.precompile += %w( amelia.css )"
    js_data = "Rails.application.config.assets.precompile += %w( amelia.js )" 
    set_css_path = set_js_path = false
  
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
    puts "Assets are defined for the plugin theme"
  end

  task :install_migrations do
    Rake::Task["evaluateme:install:migrations"].invoke
    puts "Plugin migrations are installed"
  end

  # Checks that the directory you've passed in exists (pulling the directory from the path using File.dirname),
  # and creates it if it does not, it then creates the file.

  task :initializer_file do
    path = Rails.root.join("config/initializers/").to_s
    filename = "evaluateme.rb"

    File.open(path + filename, "w+") do |f|
      src = File.expand_path("../../generators/templates/evaluateme.rb", __FILE__)
      dst = path + "plugin.rb"
      src = File.open(src)
      dest = File.open(dst, "w")
      IO.copy_stream(src, dest)
    end
    puts "Initializer file created succesfully"
  end

end
