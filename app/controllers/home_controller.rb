class HomeController < ApplicationController
  def index
    @prods_count = Product.all.count
  end
end
