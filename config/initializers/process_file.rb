module ProcessFile
  def self.update
    path_to_file = Dir.glob("#{Rails.root}/public/uploads/products/*")[0]
    if path_to_file.present?

      sleep 60

      xls = Roo::Excel.new(path_to_file)
      csv_text = xls.to_csv
      csv = CSV.parse(csv_text)#, :headers => true)

      old_products = Product.all.pluck(:id)

      csv.each do |row|
        if row[0].present? && row[2].present? && row[0] != "Наименование товара"
          full_name = row[0]
          name = row[0].gsub(/\(.+\)/,'')
          name = name.gsub(/\/.+/,'') if name
          code = row[0][/\A\S+\d/]
        end
        product = Product.create( code: code, 
                                  name: name[1..-2], 
                                  full_name: full_name,
                                  price: row[2].to_f
                                  ) if name
      end

      Product.where("id in (?)", old_products).delete_all
      File.delete(path_to_file) if File.exist?(path_to_file)
    end
  end
end