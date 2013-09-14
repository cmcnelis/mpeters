class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.string :name
      t.string :email
      t.string :company

      t.timestamps
    end
  end
end
