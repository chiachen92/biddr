class User < ApplicationRecord
  has_secure_password

  before_save :downcase_email

  has_many :auctions, dependent: :destroy

  has_many :bids, dependent: :destroy

  validates :first_name, presence: true

  validates :last_name, presence: true

  validates :email, presence: true, uniqueness: true, format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  private

  def downcase_email
    email.downcase! if email.present?
  end

end
