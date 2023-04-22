require 'rails_helper'

RSpec.describe "New Bookings", type: :system, js: true  do
  before do
    driven_by(:rack_test)
  end

  it "should display a message if there are no bookings" do
    Booking.destroy_all

    visit admin_list_bookings_path
    expect(page).to have_content("There are no bookings scheduled at this time.")
  end

  it "should display all pending bookings with the correct fields" do

    Booking.create(
      owner_first_name: "Test1",
      owner_last_name: "User1",
      pet_name: "Chip",
      pet_type_id: 1,
      duration: 2,
      date: '2024-01-01T00:00',
      price: 40
    )
    Booking.create(
      owner_first_name: "Test2",
      owner_last_name: "User2",
      pet_name: "Garfield",
      pet_type_id: 2,
      duration: 4,
      date: '2024-02-02T12:00',
      price: 80
    )

    visit admin_list_bookings_path

    expect(page).to have_content("Owner")
    expect(page).to have_content("Pet Name")
    expect(page).to have_content("Pet Type")
    expect(page).to have_content("Duration")
    expect(page).to have_content("Date")
    expect(page).to have_content("Price")
    expect(page).to have_content("Test1 User1")
    expect(page).to have_content("Test2 User2")
    expect(page).to have_content("Chip")
    expect(page).to have_content("Garfield")
    expect(page).to have_content("Dog")
    expect(page).to have_content("Cat")
    expect(page).to have_content("4 hours")
    expect(page).to have_content("2 hours")
    expect(page).to have_content("$40.00")
    expect(page).to have_content("$80.00")
    expect(page).to have_content("January 1, 2024 at 12:00am")
    expect(page).to have_content("February 2, 2024 at 12:00pm")

  end
end