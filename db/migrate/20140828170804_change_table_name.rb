class ChangeTableName < ActiveRecord::Migration
  def change
    rename_table :event_tables, :events
  end
end
