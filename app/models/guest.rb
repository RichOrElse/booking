class Guest < ApplicationRecord
  has_many :reservations

  serialize :phone_numbers, Array

  validates :email, :phone_numbers, :first_name, :last_name, presence: true

  def save_changes!
    return true unless changed?

    save!
  end

  def self.find_or_new(id: nil, **details)
    (find_by(id: id) || new).with details
  end
end
