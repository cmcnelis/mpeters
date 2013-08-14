class CreatePolicies < ActiveRecord::Migration
  def change
    create_table :policies do |t|
      t.string :number
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip_code

      t.timestamps
    end
  end
end
