# Links fo database structure and SRS document.

https://docs.google.com/document/d/1R6hnnfRAEgvIXt89PJ46HpQCzOytXF_dzCDGGceJqU0/edit
https://docs.google.com/document/d/1Hzy1Vq2CrGGrQu3GXbHV5fLY5XcT0zqFm3RHbQqJ9HA/edit

###### In brief Steps to create the plugin.

1. rails plugin new evalauteme --mountable 
2. rails plugin --help

3. rails generate scaffold article title:string text:text

4. Set the routes

  resources: articles 
  root to: "articles#index" 

=> all set


#### Integrating bootstrap in rails plugin.

1. Add this line to gemspec of the plugin so that all the dependencies will be installed automatically when plugin is installed.
   
  s.add_dependency "rails", "~> 4.0" 
  # twitter bootstrap css & javascript toolkit 
  s.add_dependency 'twitter-bootswatch-rails', '~> 3.3.2'

  # twitter bootstrap helpers gem, e.g., alerts etc...
  s.add_dependency 'twitter-bootswatch-rails-helpers'

  # to use Less. 
  s.add_dependency 'therubyracer'
 s.add_dependency 'less-rails'

  # For Jquery 
  s.add_dependency 'jquery-rails'
 
  # Gems using while developing the plugin
  s.add_development_dependency "sqlite3"

2. bundle
3. Installing theme to plugin
    rails g bootswatch:install amelia
     6.  Include in the application.css (using stylesheets with the less-rails gem of the theme)
     /*
 *= require_self
 *= require [theme_name]/loader
 *= require [theme_name]/bootswatch
*/

   7. Include in application.js ( Using Javascripts of amelia theme)
//= require jquery
//= require jquery_ujs
//= require [theme_name]/loader
//= require [theme_name]/bootswatch

   8. add the amelia stylesheets and js in assets.rb
Rails.application.config.assets.precompile += %w( amelia.css )
Rails.application.config.assets.precompile += %w( amelia.js )
9.  Include the js and stylesheets in the application.html.erb 'main layout'
  <%= stylesheet_link_tag "amelia", :media => "all" %>
  <%= javascript_include_tag "amelia" %>

13. Now run http://localhost:3000/evaluateme/articles/new#
The bootstrap theme will be reflected.

##  Using a Controller Provided by the Application
changing app/controllers/evalauteme/application_controller.rb to look like:

class Evaluateme::ApplicationController < ApplicationController
end

15. Setting the initializers settings in the hooked application for that initialize some initialized variables in the engine.
lib/evaluateme.rb 
as the initializer file

16. In the application, you can customize these global variables by
Evaluateme.setup do |config|

  config.secret_key = "application1"

  config.mailer_sender = 'admin@application1.com'

end

17. In the engine, application controller will be inherited from the application controller of the plugin.
module Evaluateme
  class   ApplicationController < Evaluateme.parent_controller.constantize
   #layout 'evaluateme/amelia'
  end
end


18. Now make the generators to configure assets, initializers and routes in the application.
Also create helper methods in the application.

10. Also the evaluateme_rake_tasks by which we can set all the things e.g
Set assets
Set routes
Initializer file

================================================================================

######  Steps to hooked in the application:

1. Add the gems in the gemfile of the application.

# Mount the plugin
gem 'evaluateme'
gem 'less-rails'
gem'twitter-bootswatch-rails', '~> 3.3.2'

2. bundle install

3. Run the generators.

rails g evaluateme:install

          -> It will set routes, assets and create initializer file.

rails g evaluateme user
     
     -> It will create the helper file and the migrations.

4. rails g evalauteme:install:migrations
    
      -> It will install all the migrations

5. rake db:migrate


6. To use the helper methods of the plugin.

include EvaluatemeHelper

>> helper.user_plugin_helper

=> “Evaluateme plugin”
