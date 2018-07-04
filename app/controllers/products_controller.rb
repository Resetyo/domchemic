class ProductsController < ApplicationController
  def index
    @grid = ProductsGrid.new(params[:products_grid]) do |scope|
      scope.page(params[:page]).per(50)
    end
    @new_list = List.new

    if current_user
      @session_id = current_user.current_session_id
    else
      @session_id = cookies[:session_id]
    end

    list = List.find_by(session_id: @session_id)
    @codes_list = list.codes_list if list
    @lists = current_user.lists if current_user
    @products = Product.all
  end

  def upload
    if uploaded_io = params[:file]
      old_files = Dir.glob("#{Rails.root}/public/uploads/products/*")
      old_files.each { |f| File.delete(f) }

      dir_name = Rails.root.join('public', 'uploads', 'products')
      FileUtils.mkdir_p(dir_name) unless File.directory?(dir_name)
      
      @filename = DateTime.now.to_s + '.xls'
      path_to_file = dir_name + @filename

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