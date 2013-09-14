class FixDeductibleColumnName < ActiveRecord::Migration
  def change
	rename_column :vehicles, :deductable, :deductible
  end
end
