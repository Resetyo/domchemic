class CreatePromoProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :promo_products do |t|
      t.string :name
      t.string :title
      t.string :image
      t.text :desc

      t.timestamps
    end
  end
end
