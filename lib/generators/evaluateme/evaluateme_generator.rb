# Evaluateme Generator needs the parameter to pass  creating the files.

class EvaluatemeGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

# Copy the helper file to the application.
  def copy_helper_file
    create_file "app/helpers/evaluateme_helper.rb", 

<<-FILE

module EvaluatemeHelper

  def #{plural_name.singularize}_plugin_helper?
    puts "Evaluateme plugin."
  end

end
FILE

  end
end