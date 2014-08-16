class CreateTrackItems < ActiveRecord::Migration
  def change
    create_table :track_items do |t|
      t.string :name
      t.integer :unit_id
      t.integer :project_id
      t.timestamps
    end
    add_index :track_items, :name
    add_index :track_items, [ :name, :project_id ] , unique: true
  end
end
