class CompanyDetailUser < ApplicationRecord
  self.table_name = 'company_details_users'
  belongs_to :company_detail
  belongs_to :user
end
