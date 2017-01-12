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
    # respond_to do |format|
    if @auction.user == current_user
      redirect_to auction_path(@auction), alert: "Cannot bid on your own auction"
    elsif (@auction.bids.present? && params[:bid][:price].to_i < @auction.bids.last.price)
        redirect_to auction_path(@auction), alert: "Bid must be higher than current bid"
        elsif @bid.save
          redirect_to auction_path(@auction), notice: "Bid created!"
          else
            flash[:alert] = "Please fix errors"
            redirect_to auction_path
          end
        end

        # respond_to do |format|
        #                 if !@auction.bids.present? || (params[:bid][:amount].to_f > @auction.bids.last.amount.to_f)
        #                     @bid = Bid.new user: current_user, auction: @auction
        #                     @bid.amount = params[:bid][:amount]
        #                     check_reserve
        #                     if @bid.save
        #                         format.js { render :bid_success }
        #                         format.html { redirect_to auction_path(@auction), notice: 'Bid placed' }
        #                     else
        #                         format.html { redirect_to auction_path(@auction), alert: bid.errors.full_messages.join(', ') }
        #                     end
        #                 else
        #                     format.html { redirect_to auction_path(@auction), alert: 'Your bid must be higher than the current bid' }
        #                 end
        #             end
        #         end
        #     end







  private

  def bid_params
    params.require(:bid).permit(:price)
  end

end
