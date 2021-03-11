require 'rails_helper'

RSpec.describe Reservation, type: :model do
  it { should be_invalid }
  it { should have_attribute :guest_id }
  it { should have_attribute :start_date }
  it { should have_attribute :end_date }
  it { should have_attribute :currency }

  describe 'booking' do
  	subject { Reservation.booking(guest: { email: 'john.doe@example.test' }) }
  	it { expect(subject.guest).to have_attributes(email: 'john.doe@example.test') }
  	it { expect(subject.guest).to be_kind_of Guest }
  end
end
