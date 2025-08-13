class AddOverallToTotals < ActiveRecord::Migration[7.1]
  def change
    add_column :totals, :overall, :integer
  end
end
