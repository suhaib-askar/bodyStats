class RemoveIndex < ActiveRecord::Migration
  def up
    remove_index :friendly_id_slugs, name: :index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope
  end

  def down
    add_index :friendly_id_slugs, [:slug, :sluggable_type, :scope], unique: true
  end
end
