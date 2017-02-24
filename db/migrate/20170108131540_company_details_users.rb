class CompanyDetailsUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :company_details_users, :id => false do |t|
      t.references :company_detail,:foreign_key => true
      t.references :user, :foreign_key => true
    end
  end
end
