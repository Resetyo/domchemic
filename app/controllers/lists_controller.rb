class ListsController < ApplicationController

  def new
    token = Digest::SHA1.hexdigest(SecureRandom.urlsafe_base64)

    if current_user
      current_user.update_attributes(current_session_id: token)
    else
      cookies[:session_id] = token
    end

    redirect_to products_path
  end

  def index
    @lists = current_user.lists
  end

  def show
    @session_id = params[:slug]
    @list = Product.user_list(@session_id)

    @grid = ProductsGrid.new(params[:products_grid]) do |scope|
      @list.page(params[:page]).per(50)
    end

    @codes_list = List.find_by(session_id:@session_id).codes_list
    @amount = 0

    @list.each do |product|
      @amount += @codes_list.count(product.code) * product.price
    end

    @amount = @amount.round(2)

    if current_user
      current_user.update_attributes(current_session_id: @session_id)    
      @lists = current_user.lists 
    end

  end

  def create
    if current_user
      @session_id = current_user.current_session_id
    else
      @session_id = cookies[:session_id]
    end

    @list = List.find_by(session_id: @session_id) 

    if @list
      @list.product_codes += "#{params[:product_codes]},"
    else
      @list = List.new(list_params)
      @list.product_codes = ",#{params[:product_codes]},"
      @list.session_id = @session_id
    end

    if current_user
      current_user.update_attributes(current_session_id: @session_id)
      @list.user_id = current_user.id
    end

    @code = params[:product_codes]
    list = List.find_by(session_id: @session_id)
    @codes_list = list.codes_list if list

    @list.save
  end

  def remove_product
    if current_user
      @session_id = current_user.current_session_id
    else
      @session_id = cookies[:session_id]
    end

    @list = List.find_by(session_id: @session_id) 
    codes = @list.product_codes.sub(params[:code],'').sub(/,,/,',')
    @list.update_attributes(product_codes: codes) if @list
    @code = params[:code]
    if codes == ','
      @list.destroy 

      if current_user
        if current_user.lists.present?
          current_user.update_attributes(current_session_id: current_user.lists.last.session_id)
        else
          current_user.update_attributes(current_session_id: nil)
        end
      end
    end
  end

  def destroy
    list = List.find_by(session_id: params[:slug])
    list.destroy

    redirect_to lists_path
  end

  private

    def list_params
      params.permit(:product_codes)
    end

end
