class AddAuthToAgents < ActiveRecord::Migration
  def change
    add_column :agents, :crypted_password, :string
    add_column :agents, :password_salt, :string
    add_column :agents, :persistence_token, :string
  end
end
