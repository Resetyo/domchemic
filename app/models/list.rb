class List < ApplicationRecord
  belongs_to :user

  def title
    "Список " +
    List
      .where(session_id: session_id)
      .first
      .created_at
      .strftime('%d-%m-%Y')
  end

  def codes_list
    self.product_codes.split(",").select { |v| v != "" }
  end
end
