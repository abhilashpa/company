class ContactDetail < ApplicationRecord
  belongs_to :company_detail

  def self.create_new_contact_detail options
    cond = ContactDetail.new
    cond.create_new_contact_detail options
  end

  def create_new_contact_detail options
    self.company_detail_id = options[:company_detail_id]
    self.email1 = options[:email_id]
    self.landline = options[:landline_no]
    self.save!
    self
  end
end
