class BookingsController < ApplicationController

  def create
    @listing = Listing.find(params[:listing_id])
    @booking = @listing.bookings.new(booking_params)
    @booking.user_id = current_user.id
    if check_dates(@booking) == true
      @booking.save
      BookingJob.perform_later(current_user.name, @listing.user_id, @listing, @booking.id)
      # BookingMailer.notification_email(current_user.name, @listing.user_id, @listing, @booking.id).deliver_later
      redirect_to '/'
    else
      render 'listings/show'
    end
  end

  private
  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :guests)
  end

  def check_dates(reservation)
    @listing = Listing.find(reservation.listing_id)
    @listing_ranges = Array.new
    if @listing.bookings.nil?
      return true
    else
      #check for clashes in existing dates
      @listing.bookings.each do |date|
        @counter = Array.new
        if (Date.strptime(date.start_date, '%m/%d/%Y')..Date.strptime(date.end_date, '%m/%d/%Y')).include?(Date.strptime(reservation.start_date, '%m/%d/%Y')) || (Date.strptime(date.start_date, '%m/%d/%Y')..Date.strptime(date.end_date, '%m/%d/%Y')).include?(Date.strptime(reservation.end_date, '%m/%d/%Y'))
          @counter << false
        else
          @counter << true
        end
      end
      #deciding factor of booking creation
      if @counter.nil?
        return true
      else
        if @counter.include?(false)
          return false
        else
          return true
        end
      end
    end
  end

end
