class Auction < ApplicationRecord

  after_initialize :set_defaults
  belongs_to :user

  has_many :bids, dependent: :destroy

  validates :title, presence: true
  validates :reserve_price, presence: true,
                            numericality: { greater_than: 0 }
  # validates_date :end_date, after: lambda { Date.current}

  include AASM

  aasm whiny_transitions: false do
    state :draft, initial: true
    state :published
    state :reserve_met
    state :won
    state :reserve_not_met
    state :cancelled

    event :publish do
      transitions from: :draft, to: :published
    end

    event :reserve_process do
      transitions from: :published, to: :reserve_met
    end

    event :sell do
      transitions from: :reserve_met, to: :won
    end

    event :reserve_fail do
      transitions from: :published,
      to: :reserve_not_met
    end

    event :cancel do
      transitions from: [:draft, :published, :reserve_met,  :won], to: :cancelled
    end
  end

    private

    def set_defaults
      self.highest_bid ||= 0
    end

end
