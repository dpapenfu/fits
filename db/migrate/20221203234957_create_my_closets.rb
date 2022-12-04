class CreateMyClosets < ActiveRecord::Migration[6.0]
  def change
    create_table :my_closets do |t|
      t.integer :user_id
      t.string :clothing
      t.string :caption

      t.timestamps
    end
  end
end
