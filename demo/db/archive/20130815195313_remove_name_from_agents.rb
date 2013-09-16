class RemoveNameFromAgents < ActiveRecord::Migration
  def change
    remove_column :agents, :name, :string
  end
end
