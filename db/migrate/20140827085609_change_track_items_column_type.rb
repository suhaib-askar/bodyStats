class ChangeTrackItemsColumnType < ActiveRecord::Migration
  def up
    change_column :track_items, :user_data, :float
  end

  def down
    change_column :track_items, :user_data, :integer
  end

end
