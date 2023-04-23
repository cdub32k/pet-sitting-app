class Booking < ApplicationRecord
  belongs_to :pet_type
  validates :owner_first_name, :owner_last_name, :pet_name, :pet_type_id, :duration, :date, presence: true
  validates :duration, numericality: { greater_than_or_equal_to: 2, less_than_or_equal_to: 8, only_integer: true }
end
