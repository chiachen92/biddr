class Auctions::Publish

  include Virtus.model

  attribute :auction
  attribute :current_user, User

  def call
    auction.publish!
  end

end
