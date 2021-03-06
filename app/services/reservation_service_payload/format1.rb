# frozen_string_literal: true

module ReservationServicePayload
  class Format1 < Struct.new(*%i{status currency})
    def initialize(data)
      super *data.values_at(:status_type, :host_currency)
    end

    def self.parse(data)
      new(data).to_h
        .merge!(Prices.parse data)
        .merge!(Reservation.parse data)
        .merge!(GuestDetails.parse data)
        .merge!(guest: Guest.parse(data))
    end

    class GuestDetails < Struct.new(:guest_details).extend ParseValuesAtMembers
      def to_h
        NumberOf.parse(guest_details).merge! description: guest_details[:localized_description]
      end
    end

    class Guest < Struct.new(:guest_id, :guest_email, :guest_first_name, :guest_last_name, :guest_phone_numbers).extend ParseValuesAtMembers
      def to_h
        super.transform_keys { |key| key.to_s.sub('guest_', '') }.symbolize_keys
      end
    end

    class Prices < Struct.new(:expected_payout_amount, :total_paid_amount_accurate, :listing_security_price_accurate).extend ParseValuesAtMembers
      def to_h
        {
          payout_price: expected_payout_amount,
          total_price: total_paid_amount_accurate,
          security_price: listing_security_price_accurate,
        }
      end
    end

    NumberOf = Struct.new(*%i{number_of_adults number_of_children number_of_infants}).extend ParseValuesAtMembers
    Reservation = Struct.new(*%i{start_date end_date nights number_of_guests}).extend ParseValuesAtMembers
  end
end
