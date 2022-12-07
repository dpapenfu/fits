class CreateFitChecks < ActiveRecord::Migration[6.0]
  def change
    create_table :fit_checks do |t|
      t.integer :user_id
      t.integer :my_closet_id

      t.timestamps
    end
  end
end
