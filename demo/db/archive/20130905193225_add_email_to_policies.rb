class AddEmailToPolicies < ActiveRecord::Migration
  def change
    add_column :policies, :email, :string
  end
end
