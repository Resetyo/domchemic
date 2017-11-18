class Setting < ApplicationRecord
  def self.get_value setting_ident
    found_setting = Setting.find_by_ident(setting_ident) unless found_setting
    found_setting ? found_setting.val : nil
  end
end
