class Createnotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.column :note, :string
      t.column :event_id, :integer

      t.timestamps
    end
  end
end
