class CreateHeadquaterAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :headquater_addresses do |t|
      t.references :company_detail, foreign_key: true
      t.references :pincode, foreign_key: true
      t.string :address1,:limit => 1000
      t.string :address2,:limit => 1000

      t.timestamps
    end
  end
end
