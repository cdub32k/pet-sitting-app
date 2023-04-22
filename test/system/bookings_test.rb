require "application_system_test_case"

class BookingsTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit bookings_url
  #
  #   assert_selector "h1", text: "Bookings"
  # end
  test "loads the form" do
    visit new_booking_path

    assert_text "New Booking"
    assert_text "Owner First Name:"
    assert_text "Owner Last Name:"
    assert_text "Pet Name:"
    assert_text "Pet Type:"
    assert_text "Appointment Length (hours):"
    assert_text "Date and Time:"
    assert_text "Total Price: N/A"
  end

  test "loads the correct initial form values with a disabled submit button" do
    visit new_booking_path

    assert_selector id: "booking_owner_first_name", text: ""
    assert_selector id: "booking_owner_last_name", text: ""
    assert_selector id: "booking_pet_name", text: ""
    assert_selector id: "booking_pet_type_id", text: "Dog Cat"
    assert_selector id: "booking_duration", text: ""
    assert_selector id: "booking_date", text: ""
    assert_selector "input[type=submit][value='Create Booking']:disabled"
  end

  test "should fill in the form values and then enable the submit button" do
    visit new_booking_path

    #check that the submit button remains disabled until all form fields are set
    fill_in "booking_owner_first_name", with: "Test"
    assert_selector "input[type=submit][value='Create Booking']:disabled"

    fill_in "booking_owner_last_name", with: "User"
    assert_selector "input[type=submit][value='Create Booking']:disabled"

    fill_in "booking_pet_name", with: "Spot"
    assert_selector "input[type=submit][value='Create Booking']:disabled"

    # pet_type_id defaults to "Dog"

    fill_in "booking_duration", with: "4"
    # total price should be pulled in after duration is set
    #assert_text "$60.00"
    assert_selector "input[type=submit][value='Create Booking']:disabled"

    fill_in "booking_date", with: "2024-01-01T00:00"
    assert_selector "input[type=submit][value='Create Booking']:not(disabled)"
  end

  test "should submit the form and redirect to the show page" do
    visit new_booking_path

    fill_in "booking_owner_first_name", with: "Test"
    fill_in "booking_owner_last_name", with: "User"
    fill_in "booking_pet_name", with: "Spot"
    #pet_type_id defaults to "Dog"
    fill_in "booking_duration", with: "4"
    fill_in "booking_date", with: "2024-01-01T00:00"
    assert_selector "input[type=submit][value='Create Booking']:not(disabled)"

    click_on "input[type=submit][value='Create Booking']"
    created_id = Booking.maximum(:id)
    expect(current_path).to eql(booking_path(created_id))
    assert_text "Appointment was succesfully created"
  end
end
