# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReservationServicePayload::Format1, type: :services do
  before(:all) do
    @payload = JSON.parse(file_fixture('format1.json').read).deep_symbolize_keys[:reservation]
  end

  let(:prices) do
    {
      payout_price:@payload[:expected_payout_amount],
      total_price: @payload[:total_paid_amount_accurate],
      security_price: @payload[:listing_security_price_accurate],
    }
  end

  let(:guest) do
    { 
      id: @payload[:guest_id],
      email: @payload[:guest_email],
      last_name: @payload[:guest_last_name],
      first_name: @payload[:guest_first_name],
      phone_numbers:  @payload[:guest_phone_numbers],
    }
  end

  let(:status) { @payload[:status_type] }
  let(:currency) { @payload[:host_currency] }
  let(:guest_details) { @payload[:guest_details] }
  let(:description) { guest_details[:localized_description] }
  let(:reservation) { @payload.slice(*%i{start_date end_date nights number_of_guests}) }
  let(:age_groups) { guest_details.slice(*%i{number_of_adults number_of_children number_of_infants}) }

  describe 'parse' do
    subject { described_class.parse @payload }

    it { should be_all(&:present?) }
    it { should have_attributes(size: 14) }
    it { should include prices, age_groups, reservation }
    it { should include guest: guest, currency: currency, status: status, description: description }
  end

  describe '::Guest.parse' do
    subject { described_class::Guest.parse @payload }
    it { should eql guest }
  end

  describe '::GuestDetails.parse' do
    subject { described_class::GuestDetails.parse @payload }
    it { should include age_groups }
  end

  describe '::Prices.parse' do
    subject { described_class::Prices.parse @payload }
    it { should eql prices }
  end

  describe '::Reservation.parse' do
    subject { described_class::Reservation.parse @payload }
    it { should eql reservation }
  end
end
