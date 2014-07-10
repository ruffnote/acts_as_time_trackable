class CreateTimeEntries < ActiveRecord::Migration
  def change
    create_table :time_entries do |t|
      t.datetime :started_at
      t.datetime :stopped_at
      t.references :time_trackable, polymorphic: true, index: { name: 'index_time_entries_on_time_trackable' }
      t.references :time_tracker, polymorphic: true, index: { name: 'index_time_entries_on_time_tracker' }

      t.timestamps
    end

    add_index :time_entries, :started_at
    add_index :time_entries, :stopped_at
  end
end
