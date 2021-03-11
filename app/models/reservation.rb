class Reservation < ApplicationRecord
  belongs_to :guest

  monetize :payout_price_cents, with_model_currency: :currency
  monetize :security_price_cents, with_model_currency: :currency
  monetize :total_price_cents, with_model_currency: :currency

  validates :start_date, :end_date, presence: true
  validates_associated :guest

  def self.booking(guest: {}, **details)
    new(details).with guest: Guest.find_or_new(guest)
  end
end
