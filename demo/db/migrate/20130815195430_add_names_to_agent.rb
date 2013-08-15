class AddNamesToAgent < ActiveRecord::Migration
  def change
    add_column :agents, :first_name, :string
    add_column :agents, :last_name, :string
  end
end
