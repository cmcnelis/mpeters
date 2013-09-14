class AddAgentIdToPolicies < ActiveRecord::Migration
  def change
    add_column :policies, :agent_id, :integer
  end
end
