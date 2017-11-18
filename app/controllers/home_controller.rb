class HomeController < ApplicationController
  def index
    @prods_count = Product.all.count
    @promo_products = PromoProduct.take(6)
    @contact = Contact.new
  end
end
