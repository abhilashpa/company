class CreateOpenings < ActiveRecord::Migration[5.0]
  def change
    create_table :openings do |t|
      t.string :position , null: false
      t.string :department, null: false
      t.integer :no_of_openings, null: false
      t.string :opening_type, null: false
      t.bigint :package_upper, null: false
      t.bigint :package_lower, null: false
      t.string :location, null: false
    end
  end
end
