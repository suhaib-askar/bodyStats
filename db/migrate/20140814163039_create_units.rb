class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :full_en
      t.string :short_en
      t.string :full_ru
      t.string :short_ru
      t.timestamps
    end
  end
end
