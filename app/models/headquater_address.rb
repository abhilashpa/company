class HeadquaterAddress < ApplicationRecord
  belongs_to :company_detail
  belongs_to :pincode

  def self.create_new_headquater options
    ha = HeadquaterAddress.new
    ha.create_headquater_address options
  end

  def create_headquater_address options
    self.company_detail_id = options[:company_detail_id]
    self.address1 = options[:address_line_1]
    self.address2 = options[:address_line_2]
    self.pincode_id = options[:pincode_id]
    self.save!
    self
  end
end
