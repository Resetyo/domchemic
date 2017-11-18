class ProductsGrid

  include Datagrid

  scope do
    Product
  end
  filter(:name, :string, header: 'Поиск по наименованию') do |value| 
    where("LOWER(products.code) LIKE :val OR LOWER(name) LIKE :val", val: "%#{value.mb_chars.downcase.to_s}%")
  end
  column(:code, header: 'Код')
  column(:name, header: 'Наименование') do |model|
    format(model.name) do |name|
      render partial: "products/product_form", 
              locals: { model: model, 
                        new_list: @new_list, 
                        codes_list: @codes_list,
                        session_id: @session_id }
    end
  end
  column(:price, header: 'Цена') do |model|
    format(model.price) do |price|
      render partial: "products/product_price", 
              locals: { model: model,
                        price: price,
                        session_id: @session_id }
    end
  end
end
 