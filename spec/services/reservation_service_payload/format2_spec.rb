# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReservationServicePayload::Format2, type: :services do
  before(:all) do
    @payload = JSON.parse(file_fixture('format2.json').read).deep_symbolize_keys
  end

  let(:prices) do
    @payload.slice(*%i{payout_price security_price total_price})
  end

  let(:guest) do
    payload_guest = @payload[:guest]
    payload_guest.slice(*%i{id first_name last_name email})
                 .merge phone_numbers: [payload_guest[:phone]]
  end

  let(:age_groups) do
    {
      number_of_guests: @payload[:guests],
      number_of_adults: @payload[:adults],
      number_of_infants: @payload[:infants],
      number_of_children: @payload[:children],
    }
  end

  let(:currency) { @payload[:currency] }
  let(:reservation) { @payload.slice(*%i{start_date end_date nights status currency}) }

  describe 'parse' do
    subject { described_class.parse @payload }

    it { should be_all(&:present?) }
    it { should have_attributes(size: 13) }
    it { should include prices, age_groups, reservation }
    it { should include guest: guest }
    it { should_not have_key :description }
  end

  describe '::Guest.parse' do
    subject { described_class::Guest.parse @payload }
    it { should eql guest }
  end

  describe '::Prices.parse' do
    subject { described_class::Prices.parse @payload }
    it { should eql prices }
  end

  describe '::NumberOf.parse' do
    subject { described_class::NumberOf.parse @payload }
    it { should eql age_groups }
  end

  describe '::Reservation.parse' do
    subject { described_class::Reservation.parse @payload }
    it { should eql reservation }
  end
end
