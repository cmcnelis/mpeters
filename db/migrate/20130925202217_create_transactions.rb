class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :amount
      t.string :pp_id
      t.boolean :approved
      t.references :vehicle, index: true
      t.string :address
      t.string :city
      t.string :zip_code
      t.string :card_number
      t.string :card_type
      t.string :csc
      t.string :exp
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
