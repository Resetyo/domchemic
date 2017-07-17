class ProductsController < ApplicationController
  def index
    @grid = ProductsGrid.new(params[:products_grid]) do |scope|
      scope.page(params[:page]).per(50)
    end
    @new_list = List.new
    @codes_list = Product.codes_list(cookies[:session_id])
    @session_id = cookies[:session_id]
  end

  def upload
    if uploaded_io = params[:file]
      old_files = Dir.glob("#{Rails.root}/public/uploads/products/*")
      old_files.each { |f| File.delete(f) }

      @filename = DateTime.now.to_s + '.xls'
      path_to_file = Rails.root.join('public', 'uploads', 'products', @filename)
      File.open(path_to_file, 'w') do |file|
        file.write(uploaded_io.read.force_encoding("utf-8"))
      end
    end
    redirect_to rails_admin_path
  end

  def delete_price
    old_files = Dir.glob("#{Rails.root}/public/uploads/products/*")
    old_files.each { |f| File.delete(f) }

    redirect_to rails_admin_path
  end
end