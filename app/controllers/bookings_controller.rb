class BookingsController < ApplicationController
  include PricingEngineHelper
  helper_method :calc_price

  def show
    @booking = Booking.find(params[:id])
  end
  def new
    @booking = Booking.new
  end
  def create
    @booking = Booking.new(
      params.require(:booking)
            .permit(:owner_first_name, :owner_last_name, :pet_name, :pet_type_id, :duration, :date))
    
    @booking.price = calc_price(@booking.pet_type_id, @booking.duration)
    if @booking.save
      redirect_to @booking, notice: "Appointment was succesfully created! #{view_context.link_to('Book another time', controller: "bookings", action: "new")}".html_safe
    else
    end
  end
end
