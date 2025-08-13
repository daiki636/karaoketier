class CreateTweets < ActiveRecord::Migration[7.1]
  def change
    create_table :tweets do |t|
      t.string :song
      t.string :artist
      t.integer :overall
      t.integer :level
      t.string :comment

      t.timestamps
    end
  end
end
