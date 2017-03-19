class CreateContactDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :contact_details do |t|
      t.references :company_detail, foreign_key: true
      t.string :email1, null: false
      t.string :email2
      t.integer :landline, null: false
      t.integer :hr_extension
      t.bigint :mobile_phone

      t.timestamps
    end
    add_index :contact_details, :email1, unique: true
    add_index :contact_details, :email2, unique: true
  end
end
