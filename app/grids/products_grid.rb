class ProductsGrid

  include Datagrid

  scope do
    Product
  end
  filter(:name, :string, header: 'Поиск по наименованию') { |value| where("name ilike '%#{value}%'") }

  column(:name, header: 'Наименование')
  column(:price, header: 'Цена') do
    "#{price} руб."
  end
end
