require 'rails/generators/migration'

class TimeTrackableGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  source_root File.expand_path('../templates', __FILE__)

  def self.next_migration_number(path)
    Time.now.utc.strftime('%Y%m%d%H%M%S')
  end

  def create_model_file
    store = 'active_record'
    copy_file "#{store}/time_entry.rb", 'app/models/time_entry.rb'
    migration_template "#{store}/create_time_entries.rb", 'db/migrate/create_time_entries.rb'
  end
end

