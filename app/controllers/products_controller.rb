class ProductsController < ApplicationController
  def index
    @grid = ProductsGrid.new(params[:products_grid]) do |scope|
      scope.page(params[:page]).per(70)
    end
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
end