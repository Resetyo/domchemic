namespace :admin do
  task :create => :environment do
    puts "Enter password"
    p = STDIN.gets
    user = User.create!(email: 'admin@example.com', password: p, password_confirmation: p )
    user.add_role :admin
  end
end