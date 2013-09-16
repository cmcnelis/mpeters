class CreateAgentSessions < ActiveRecord::Migration
  def change
    create_table :agent_sessions do |t|

      t.timestamps
    end
  end
end
