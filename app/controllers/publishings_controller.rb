class PublishingsController < ApplicationController
  def create
    auction = Auction.find params[:auction_id]
    service = Auctions::Publish.new({ auction: auction, current_user: current_user })
    if service.call
      redirect_to auction, notice: "auction published"
    else
      redirect_to auction, notice: "Can't publish auction"
    end
  end
end
