class Product < ApplicationRecord

  mount_uploader :image, ProductUploader

  def self.user_list session_id
    Product.where("code in (?)", List.find_by(session_id: session_id).codes_list)
  end

  def quantity_in_list session_id
    list = List.find_by(session_id: session_id)
    codes_list = list.codes_list if list
    codes_list ? codes_list.count(self.code) : 0
  end
end
