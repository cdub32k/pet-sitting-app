require "test_helper"

class BookingTest < ActiveSupport::TestCase
  test "Booking model presence validations" do
    bookingValidPresence = Booking.new(
      owner_first_name: "Test1",
      owner_last_name: "User1",
      pet_name: "Chip",
      pet_type_id: 1,
      duration: 2,
      date: '2024-01-01T00:00',
      price: 40
    )

    bookingInvalidPresence = Booking.new()

    assert bookingValidPresence.valid?
    assert !bookingInvalidPresence.valid?
    assert bookingInvalidPresence.errors.full_messages.include? "Owner first name can't be blank"
    assert bookingInvalidPresence.errors.full_messages.include? "Owner last name can't be blank"
    assert bookingInvalidPresence.errors.full_messages.include? "Pet name can't be blank"
    assert bookingInvalidPresence.errors.full_messages.include? "Pet type must exist"
    assert bookingInvalidPresence.errors.full_messages.include? "Pet type can't be blank"
    assert bookingInvalidPresence.errors.full_messages.include? "Duration can't be blank"
    assert bookingInvalidPresence.errors.full_messages.include? "Duration is not a number"
  end

  test "Booking model duration validations" do
    bookingValidDuration = Booking.new(
      owner_first_name: "Test1",
      owner_last_name: "User1",
      pet_name: "Chip",
      pet_type_id: 1,
      duration: 2,
      date: '2024-01-01T00:00',
      price: 40
    )

    bookingInvalidDuration = Booking.new(
      owner_first_name: "Test1",
      owner_last_name: "User1",
      pet_name: "Chip",
      pet_type_id: 1,
      duration: 10,
      date: '2024-01-01T00:00',
      price: 40
    )

    bookingInvalidDuration2 = Booking.new(
      owner_first_name: "Test1",
      owner_last_name: "User1",
      pet_name: "Chip",
      pet_type_id: 1,
      duration: 10,
      date: '2024-01-01T00:00',
      price: 40
    )

    assert bookingValidDuration.valid?
    assert !bookingInvalidDuration.valid?
    assert !bookingInvalidDuration2.valid?
    assert bookingInvalidDuration2.errors.full_messages.include? "Duration must be less than or equal to 8"
  end
end
