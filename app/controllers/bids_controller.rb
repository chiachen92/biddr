class BidsController < ApplicationController

  before_action :authenticate_user!
  def index
    @bids = current_user.bids
  end


  def create
    @auction = Auction.find params[:auction_id]
    @bid = Bid.new bid_params
    @bid.auction = @auction
    @bid.user = current_user
    @previous_bid = @auction.current_bid
    respond_to do |format|
      if @auction.user == current_user
        redirect_to auction_path(@auction), alert: "Cannot bid on your own auction"
      elsif (@auction.bids.present? && params[:bid][:price].to_i < @auction.bids.last.price)
        redirect_to auction_path(@auction), alert: "Bid must be higher than current bid"
      elsif @bid.save
        format.html { redirect_to auction_path(@auction), notice: "Bid created!"}
        format.js { render :create_success}
      else
        format.html {render "auctions/show"}
        format.js {render :create_failure}
      end
    end
  end

  private

  def bid_params
    params.require(:bid).permit(:price)
  end

end
