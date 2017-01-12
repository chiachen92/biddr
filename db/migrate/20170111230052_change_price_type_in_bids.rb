class ChangePriceTypeInBids < ActiveRecord::Migration[5.0]
  def change
    change_column :bids, :price, 'integer USING CAST(price AS integer)'
  end
end
