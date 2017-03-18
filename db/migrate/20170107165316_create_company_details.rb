class CreateCompanyDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :company_details do |t|
      t.string :name, null: false
      t.integer :no_of_employees, null: false
      t.bigint :annual_revenue, null: false

      t.timestamps
    end
    add_index :company_details, :name,                unique: true
  end
end
