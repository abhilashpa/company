class CompanyDetailUser < ApplicationRecord
  self.table_name = 'company_details_users'
  belongs_to :company_detail
  belongs_to :user

  def self.create_new_company_detail_user options
    cdu = CompanyDetailUser.new
    cdu.create_company_detail_user options
  end

  def create_company_detail_user options
    self.user_id = options[:user_id]
    self.company_detail_id = options[:company_detail_id]
    self.save!
    self
  end
end
