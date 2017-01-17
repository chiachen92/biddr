require 'rails_helper'

RSpec.describe Bid, type: :model do
  describe 'validations' do
    it 'requires a price' do
      b = Bid.new
      b.valid?
      expect(b.errors).to have_key(:price)
    end
  end
end
