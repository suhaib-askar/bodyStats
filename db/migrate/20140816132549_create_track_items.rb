class CreateTrackItems < ActiveRecord::Migration
  def change
    create_table :track_items do |t|
      t.integer :data
      t.integer :item_id
      t.timestamps
    end
  end
end
