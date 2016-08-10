class CreateToDoLists < ActiveRecord::Migration
  def change
    create_table :to_do_lists do |t|
      t.string :name
      t.datetime :due_at
      t.integer :user_id
      t.timestamps
    end
  end
end
