class RenameTrackItemsColumn < ActiveRecord::Migration
  def change
    rename_column :track_items, :data, :user_data
  end
end
