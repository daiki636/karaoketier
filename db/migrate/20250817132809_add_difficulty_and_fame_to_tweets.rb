class AddDifficultyAndFameToTweets < ActiveRecord::Migration[7.1]
  def change
    add_column :tweets, :difficulty, :float
    add_column :tweets, :fame, :float
  end
end
