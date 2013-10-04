class AddLastRequestAtToAgent < ActiveRecord::Migration
  def change
    add_column :agents, :last_request_at, :datetime
  end
end
