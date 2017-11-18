class ListsController < ApplicationController
  def index
    @list = Product.user_list(cookies[:session_id])
    @grid = ProductsGrid.new(params[:products_grid]) do |scope|
      @list.page(params[:page]).per(50)
    end
    @codes_list = Product.codes_list(cookies[:session_id])
    @session_id = cookies[:session_id]
    @amount = 0
    @list.each do |product|
      @amount += @codes_list.count(product.code) * product.price
    end
    @amount = @amount.round(2)
  end

  def create
    @list = List.find_by(session_id: cookies[:session_id]) 
    if @list
      @list.product_codes += "#{params[:product_codes]},"
    else
      @list = List.new(list_params)
      @list.product_codes = ",#{params[:product_codes]},"
      @list.session_id = cookies[:session_id]
    end
    @code = params[:product_codes]
    @codes_list = Product.codes_list(cookies[:session_id])
    @session_id = cookies[:session_id]
    @list.save
  end

  def remove_product
    @list = List.find_by(session_id: cookies[:session_id]) 
    codes = @list.product_codes.sub(params[:code],'').sub(/,,/,',')
    @list.update_attributes(product_codes: codes) if @list
    @code = params[:code]
  end

  private

    def list_params
      params.permit(:product_codes)
    end

end
