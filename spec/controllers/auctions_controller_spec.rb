require 'rails_helper'

RSpec.describe AuctionsController, type: :controller do

  describe "#new" do
    let(:auction) {FactoryGirl.create :auction}
    it "instantiates a new auction object and set it to @auction" do
      get :new
      expect(assigns(:auction)).to be_a_new(Auction)
    end
  end


  describe "#create" do
    let(:auction) {FactoryGirl.create :auction}
    it 'saves a new auction in the database' do
      count_before = Auction.count
      auction_params
      count_after = Auction.count
      expect(count_after).to eq(count_before + 1)
    end
    it 'does not saves the record to the database' do
      count_before = Auction.count
      auction_params
      count_after = Auction.count
      expect(count_after).to eq(count_before)
    end
    it "redirects to the auction show page" do
      auction_params = FactoryGirl.attributes_for(:auction)
      post :create, params: { auction: auction_params }
      expect(response).to redirect_to auction_path
    end
  end

end
