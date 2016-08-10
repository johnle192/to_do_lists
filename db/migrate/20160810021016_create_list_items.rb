class CreateListItems < ActiveRecord::Migration
  def change
    create_table :list_items do |t|
      t.text :title
      t.integer :list_id
      t.boolean :completed, default: false
      t.timestamps
    end
  end
end
