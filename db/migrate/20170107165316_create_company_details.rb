class CreateCompanyDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :company_details do |t|
      t.string :name
      t.integer :no_of_employees
      t.bigint :annual_revenue

      t.timestamps
    end
  end
end
