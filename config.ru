require './config/environment'

if ActiveRecord::Base.connection.migration_context.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride #allows PATCH and DELETE in controllers

# mount other controllers with 'use'
use UsersController
use CharactersController
run ApplicationController
