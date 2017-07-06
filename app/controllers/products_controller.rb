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
      csv_text = xls.to_csv
      csv = CSV.parse(csv_text)[7..-1]#, :headers => true)

      File.delete(path_to_file) if File.exist?(path_to_file)
      old_products = Product.all.pluck(:id)

      parts = (csv.count / 1000).to_i + 1
      (1..parts).each do |i|
        logger.info "=============================#{i}"
        Kaminari.paginate_array(csv).page(i).per(1000).each_with_index do |row, index|
          name = row[0][/\s.+(\/|\()/]
          if name
            product = Product.create(name: name[1..-2], price: row[2].to_f)
            logger.warn product.errors.full_messages
          end
        end
      end

      Product.where("id in (?)", old_products).delete_all

    end
    redirect_to rails_admin_path
  end

end

