# frozen_string_literal: true

module ReservationServicePayload
  class Format2
    def self.parse(data)
      Reservation.parse(data)
        .merge!(Prices.parse data)
        .merge!(NumberOf.parse data)
        .merge!(guest: Guest.parse(data))
    end

    class Guest < Struct.new(:guest).extend ParseValuesAtMembers
      def to_h
        Data.parse(guest).merge! phone_numbers: [guest[:phone]]
      end
    end

    class NumberOf < Struct.new(:guests, :adults, :children, :infants).extend ParseValuesAtMembers
      def to_h
        super.transform_keys! { |age_group| :"number_of_#{age_group}" }
      end
    end

    Guest::Data = Struct.new(*%i{id first_name last_name email}).extend ParseValuesAtMembers
    Prices = Struct.new(*%i{payout_price security_price total_price}).extend ParseValuesAtMembers
    Reservation = Struct.new(*%i{start_date end_date nights status currency}).extend ParseValuesAtMembers
  end
end
