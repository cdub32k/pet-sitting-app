class AdminController < ApplicationController
  def list_bookings
    @bookings = Booking.all
  end
end
