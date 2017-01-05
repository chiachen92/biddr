class AuctionsController < ApplicationController

  def new
    @auction = Auction.new
  end

  def create
    @auction = Auction.new auction_params
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
  end

  def index
    @auctions = Auction.order(created_at: :desc)
  end




  private

  def auction_params
    params.require(:auction).permit([:title, :details, :end_date, :reserve_price])
  end

end
