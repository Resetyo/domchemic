class AddCodeToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :code, :string
  end
end
