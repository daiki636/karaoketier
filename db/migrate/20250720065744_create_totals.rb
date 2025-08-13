class CreateTotals < ActiveRecord::Migration[7.1]
  def change
    create_table :totals do |t|
    t.integer :total   # 必要なカラムを追加してください
      t.timestamps
    end
  end
end
