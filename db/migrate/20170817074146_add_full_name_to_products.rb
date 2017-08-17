class AddFullNameToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :full_name, :string
  end
end
