# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

app_environment_variables = File.join(Rails.root, 'config', 'application.yml')
load(app_environment_variables) if File.exists?(app_environment_variables)