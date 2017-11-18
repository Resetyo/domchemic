class Product < ApplicationRecord
  def self.user_list session_id
    Product.where("code in (?)", codes_list(session_id))
  end

  def self.codes_list session_id
    list = List.find_by(session_id: session_id)
    codes = list ? list.product_codes.split(",").select { |v| v != "" } : nil
  end

  def quantity_in_list session_id
    codes_list = Product.codes_list(session_id)
    codes_list ? codes_list.count(self.code) : 0
  end
end
