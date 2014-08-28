class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.column :name, :string

      t.timestamps
    end
    add_column :event_tables, :user_id, :integer
  end
end
