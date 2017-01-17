require 'rails_helper'

RSpec.describe Auction, type: :model do
  it 'requires a title' do
    a = Auction.new
    a.valid?
    expect(a.errors).to have_key(:title)
  end


  it 'requires a user' do
    u = User.new
    u.valid?
    expect(u.errors).to have_key(:user)
  end
end
