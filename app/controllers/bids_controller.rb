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
        @error_message = "Cannot bid on your own auction"
        format.html { redirect_to auction_path(@auction), alert: "Cannot bid on your own auction"}
        format.js {render :create_failure}
      elsif (@auction.bids.present? && params[:bid][:price].to_i < @auction.bids.last.price)
        @error_message = "Bid must be higher than current bid"
        format.html { redirect_to auction_path(@auction), alert: "Bid must be higher than current bid"}
        format.js {render :create_failure}
      else
        @bid.save
        @auction = Auction.find params[:auction_id]
        format.html { redirect_to auction_path(@auction), notice: "Bid created!"}
        format.js { render :create_success }
      end
    end
  end

  private

  def bid_params
    params.require(:bid).permit(:price)
  end

end
