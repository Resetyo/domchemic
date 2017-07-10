module ProcessFile
  def self.update
    path_to_file = Dir.glob("#{Rails.root}/public/uploads/products/*")[0]
    if path_to_file.present?

      sleep 30

      xls = Roo::Excel.new(path_to_file)
      csv_text = xls.to_csv
      csv = CSV.parse(csv_text)#, :headers => true)

      old_products = Product.all.pluck(:id)

      csv.each_with_index do |row, index|
        name = row[0][/\s.+(\/|\()/]
        product = Product.create(name: name[1..-2], price: row[2].to_f) if name && row[2].present?
      end

      Product.where("id in (?)", old_products).delete_all
      File.delete(path_to_file) if File.exist?(path_to_file)
    end
  end
end