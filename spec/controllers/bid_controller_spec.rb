require 'rails_helper'

RSpec.describe BidController, type: :controller do
  describe '#create' do
    context 'with no user signed in' do
      it 'redirects to sign in page' do
        post :create, {bid: {price: "123"}}
        expect(response).to
        redirect_to(new_session_path)
      end
    end
  end
end
