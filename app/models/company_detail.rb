class CompanyDetail < ApplicationRecord
  has_many :company_detail_users

  def self.create_new_company_detail options
    cd = CompanyDetail.new
    cd.create_company_detail options
  end

  def create_company_detail options
    self.name = options[:company_name]
    self.annual_revenue = options[:annual_revenue]
    self.no_of_employees = options[:no_of_employees]
    self.save!
    self
  end
end
