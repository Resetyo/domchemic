role :app, %w(hosting_domhimik@neon.locum.ru)
role :web, %w(hosting_domhimik@neon.locum.ru)
role :db, %w(hosting_domhimik@neon.locum.ru)

set :ssh_options, forward_agent: true
set :rails_env, :production

# role :app, %w(hosting_ostorodonodor@neon.locum.ru)
# role :web, %w(hosting_ostorodonodor@neon.locum.ru)
# role :db, %w(hosting_ostorodonodor@neon.locum.ru)
