module ProcessFile
  def self.update
    path_to_file = Dir.glob("#{Rails.root}/public/uploads/products/*")[0]
    if path_to_file.present?
      puts "#{DateTime.now} file found"

      xls = Roo::Excel.new(path_to_file)
      csv_text = xls.to_csv
      csv = CSV.parse(csv_text)#, :headers => true)

      old_products = Product.all.pluck(:id)

      Product.transaction do
        csv.each do |row|
          if row[0].present? && row[2].present? && row[0] != "Наименование товара"
            full_name = row[0]
            name = row[0].gsub(/\(.+\)/,'')
            name = name.gsub(/\/.+/,'') if name
            code = row[0][/\A\S+\d/]
          end
          if name
            product = Product.create( code: code, 
                                      name: name[1..-2], 
                                      full_name: full_name,
                                      price: row[2].to_f
                                      )

            slug_code = SlugPreparatorRus.slug code, 'no-code'
            image_folder = "#{Rails.root}/public/uploads/product/image/#{slug_code}"

            if File.directory?(image_folder)
              image_path = Dir.entries(image_folder).select do |i|
                i[0..5] != "thumb_" && i.length > 4
              end
              image_path = "#{image_folder}/#{image_path[0]}"

              product.image = File.open(image_path) if File.exist?(image_path)
            end

            product.save
          end
        end
      end

      Product.where("id in (?)", old_products).delete_all
      File.delete(path_to_file) if File.exist?(path_to_file)
    end
  end
end