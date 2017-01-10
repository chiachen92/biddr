class AuctionsController < ApplicationController

  before_action :authenticate_user!,
  only: [:create, :new]

  def new
    @auction = Auction.new
  end

  def create
    @auction = Auction.new auction_params
    @auction.user = current_user
    if @auction.save
      redirect_to auction_path(@auction)
      flash[:success] = "Auction was successfully created"
    else
      flash[:alert] = "Please fix errors"
      render :new
    end
  end

  def show
    @auction = Auction.find params[:id]
    @bid = Bid.new
  end

  def index
    @auctions = Auction.order(created_at: :desc)
  end




  private

  def auction_params
    params.require(:auction).permit(:title, :details, :end_date, :reserve_price, :highest_bid)
  end

end
