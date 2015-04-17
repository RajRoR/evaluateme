# Evaluateme Generator needs the parameter to pass  creating the files.

class EvaluatemeGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

# Copy the helper file to the application.
  def copy_helper_file
    create_file "app/helpers/evaluateme_helper.rb", 
<<-FILE

module EvaluatemeHelper
  
  def #{plural_name.singularize}_plugin_helper
    puts "Evaluateme plugin."
  end

end
FILE
    puts "Helper file has created"
  end

# Create the migration for adding new field to the passed parameter of model name
# of the hooked application. 

  def create_user_migration
    create_file "db/migrate/add_evaluateme_fields_to_#{plural_name}",
<<-MIGRATION

class AddEvaluatemeTo#{plural_name.capitalize} < ActiveRecord::Migration
  def change
    add_column :#{plural_name}, :kra_locked, :boolean, :default => false
  end
end

MIGRATION
  end

end