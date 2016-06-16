class AddDurationToTimeEntries < ActiveRecord::Migration
  def change
    add_column :time_entries, :duration, :integer, null: false, default: 0
    add_index :time_entries, :duration
  end
end
