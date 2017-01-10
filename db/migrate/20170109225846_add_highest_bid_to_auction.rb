class AddHighestBidToAuction < ActiveRecord::Migration[5.0]
  def change
    add_column :auctions, :highest_bid, :integer
  end
end
