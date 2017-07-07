class ProductsGrid

  include Datagrid

  scope do
    Product
  end
  filter(:name, :string, header: 'Поиск по наименованию') { |value| where("LOWER(name) LIKE ?", "%#{value.mb_chars.downcase.to_s}%") }

  column(:name, header: 'Наименование')
  column(:price, header: 'Цена') do
    "#{price} руб."
  end
end
