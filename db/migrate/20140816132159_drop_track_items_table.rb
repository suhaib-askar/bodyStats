class DropTrackItemsTable < ActiveRecord::Migration
  def change
    drop_table :track_items
  end
end
