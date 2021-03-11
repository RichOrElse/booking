require 'rails_helper'

RSpec.describe Guest, type: :model do
  it { should be_invalid }
  it { should have_attribute :email }
  it { should have_attribute :last_name }
  it { should have_attribute :first_name }
  it { should have_attribute :phone_numbers }

  context "with complete details" do
    subject do
      Guest.new(email: 'john.doe@example.test', phone_numbers: [5555555], first_name: 'John', last_name: 'Doe')
    end

    it { should be_valid }
  end
end
