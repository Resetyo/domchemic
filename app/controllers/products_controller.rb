class ProductsController < ApplicationController
  def index
    @grid = ProductsGrid.new(params[:products_grid]) do |scope|
      scope.page(params[:page]).per(70)
    end
  end

  def upload
    if uploaded_io = params[:file]
      @filename = DateTime.now.to_s + '.xls'
      path_to_file = Rails.root.join('public', 'uploads', 'products', @filename)
      File.open(path_to_file, 'w') do |file|
        file.write(uploaded_io.read.force_encoding("utf-8"))
      end

      xls = Roo::Excel.new(path_to_file)
      File.delete(path_to_file) if File.exist?(path_to_file)
      csv_text = xls.to_csv
      csv = CSV.parse(csv_text)#, :headers => true)

      old_products = Product.all.to_a

      csv[7..-1].each_with_index do |row, index|
        logger.warn row[0]
        name = row[0][/\s.+(\/|\()/]
        if name
          product = Product.create(name: name[1..-2], price: row[2].to_f)
          logger.warn product.errors.full_messages
        end
      end

      #REMOVE FILE

      old_products.each do |product|
        product.destroy
      end

    end
    redirect_to rails_admin_path
  end

end

