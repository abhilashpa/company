class AddColumnsToCompanyDetails < ActiveRecord::Migration[5.0]
  def change
  	add_column :company_details, :logo_url, :string
  	add_column :company_details, :started_in, :integer
  	add_column :company_details, :website_url, :string
  	add_column :company_details, :ceo_name, :string
  	add_column :company_details, :ceo_image_url, :string
  	add_column :company_details, :description, :text
  end
end
