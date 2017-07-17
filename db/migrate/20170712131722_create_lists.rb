class CreateLists < ActiveRecord::Migration[5.0]
  def change
    create_table :lists do |t|
      t.string :product_codes
      t.string :session_id

      t.timestamps
    end
  end
end
