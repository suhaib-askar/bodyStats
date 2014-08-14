class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :track_items, :unit, :unit_id
  end
end
