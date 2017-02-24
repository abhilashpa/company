class CreateContactDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :contact_details do |t|
      t.references :company_detail, foreign_key: true
      t.string :email1
      t.string :email2
      t.integer :landline
      t.integer :hr_extension
      t.bigint :mobile_phone

      t.timestamps
    end
  end
end
