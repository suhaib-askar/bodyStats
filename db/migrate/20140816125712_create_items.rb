class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.integer :unit_id
      t.integer :project_id
      t.timestamps
    end
    add_index :items, :name
    add_index :items, [ :name, :project_id ] , unique: true
  end
end
