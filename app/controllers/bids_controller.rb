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
    if @auction.user == current_user
      redirect_to auction_path(@auction), alert: "Cannot bid on your own auction"
    elsif @bid.price.to_i < @auction.reserve_price.to_i
        redirect_to auction_path(@auction), alert: "Bid must be higher than current bid"
        elsif @bid.save
          redirect_to auction_path(@auction), notice: "Bid created!"
          else
            flash[:alert] = "Please fix errors"
            redirect_to auction_path
          end
        end








  private

  def bid_params
    params.require(:bid).permit(:price)
  end

end
