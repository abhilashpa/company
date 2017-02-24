class HeadquaterAddress < ApplicationRecord
  belongs_to :company_detail
  belongs_to :pincode
end
