require 'rails_helper'

RSpec.describe "New Bookings", type: :system, js: true  do
  before do
    driven_by :selenium_chrome_headless, screen_size: [1400, 1400]
  end

  it "loads the form" do
    visit new_booking_path

    expect(page).to have_content("New Booking")
    expect(page).to have_content("Owner First Name:")
    expect(page).to have_content("Owner Last Name:")
    expect(page).to have_content("Pet Name:")
    expect(page).to have_content("Pet Type:")
    expect(page).to have_content("Appointment Length (hours):")
    expect(page).to have_content("Date and Time:")
    expect(page).to have_content("Total Price: N/A")
  end

  it "loads the correct initial form values with a disabled submit button" do
    visit new_booking_path

    expect(page).to have_field("booking_owner_first_name", text: "")
    expect(page).to have_field("booking_owner_last_name", text: "")
    expect(page).to have_field("booking_pet_name", text: "")
    expect(page).to have_field("booking_pet_type_id", text: "Dog\nCat")
    expect(page).to have_field("booking_duration", text: "")
    expect(page).to have_field("booking_date", text: "")
    expect(page).to have_selector("input[type=submit][value='Create Booking']:disabled")
  end

  it "should fill in the form values and then enable the submit button" do
    visit new_booking_path

    #check that the submit button remains disabled until all form fields are set
    fill_in("booking_owner_first_name", with: "Test")
    page.find :css, "input[type=submit][value='Create Booking']:disabled"

    fill_in("booking_owner_last_name", with: "User")
    page.find :css, "input[type=submit][value='Create Booking']:disabled"

    fill_in("booking_pet_name", with: "Spot")
    page.find :css, "input[type=submit][value='Create Booking']:disabled"

    # pet_type_id defaults to "Dog"

    fill_in("booking_duration", with: "4")
    page.find :css, "input[type=submit][value='Create Booking']:disabled"

    fill_in("booking_date", with: (DateTime.current + 2*60*60).strftime("%m%d%Y\t%I%M%P"))
    page.find :css, "input[type=submit][value='Create Booking']:not(disabled)"
  end

  it "should submit the form and redirect to the show page" do
    visit new_booking_path

    fill_in("booking_owner_first_name", with: "Test")
    fill_in("booking_owner_last_name", with: "User")
    fill_in("booking_pet_name", with: "Spot")
    #pet_type_id defaults to "Dog"
    fill_in("booking_duration", with: "4")
    fill_in("booking_date", with: "01012024\t1200am")
    page.find :css, "input[type=submit][value='Create Booking']:not(disabled)"

    find("input[type=submit][value='Create Booking']:not(disabled)").click
    sleep 0.5
    created_id = Booking.maximum(:id)
    expect(current_path).to eql(booking_path(created_id))
    expect(page).to have_content("Appointment was succesfully created!")
    expect(page).to have_content("Test User")
    expect(page).to have_content("Spot")
    expect(page).to have_content("Dog")
    expect(page).to have_content("4 hours")
    expect(page).to have_content("$60.00")
    expect(page).to have_content("January 1, 2024 at 12:00am")
  end

  it "should not allow creating a booking less than 1 hour from now" do
    visit new_booking_path

    fill_in("booking_owner_first_name", with: "Test")
    fill_in("booking_owner_last_name", with: "User")
    fill_in("booking_pet_name", with: "Spot")
    #pet_type_id defaults to "Dog"
    fill_in("booking_duration", with: "4")
    #attempt to create a booking this very minute
    now = Time.new
    fill_in("booking_date", with: now.strftime("%Y%m%d\t%H%M%P"))
    page.find :css, "input[type=submit][value='Create Booking']:not(disabled)"

    find("input[type=submit][value='Create Booking']").click
    #should not succeed, show validation error, and remain on new_booking_path
    expect(current_path).to eql(new_booking_path)
    error_message = page.find(:css, "#booking_date").native.attribute("validationMessage")
    expect(error_message).not_to be_blank
  end
end