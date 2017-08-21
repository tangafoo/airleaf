class BookingsController < ApplicationController

  def create
    @listing = Listing.find(params[:listing_id])
    @booking = @listing.bookings.new(booking_params)
    @booking.user_id = current_user.id
    if @booking.save
      redirect_to '/'
    else
      render 'listings/show'
    end
  end

  private
  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :guests)
  end

end
