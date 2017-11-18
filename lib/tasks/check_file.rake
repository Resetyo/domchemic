namespace :check_file do
  task :price => :environment do
    ProcessFile.update
  end
end