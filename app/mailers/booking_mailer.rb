class BookingMailer < ApplicationMailer

  default from: 'chevaliertann@gmail.com'


  def notification_email(customer, host_id, listing, booking_id)
    @customer = customer
    @host = User.find(host_id)
    @listing = listing
    @booking_id = booking_id
    mail(to: @host.email, subject: "You have received a booking for one of your listing(s)!")
  end

end
