class AddTierToTweets < ActiveRecord::Migration[7.1]
  def change
    add_column :tweets, :tier, :integer
  end
end
