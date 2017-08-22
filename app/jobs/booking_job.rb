class BookingJob < ApplicationJob
  queue_as :default

  def perform(customer, host_id, listing_id, booking_id)
    BookingMailer.notification_email(customer, host_id, listing_id, booking_id).deliver_now
    # Do something later
  end
end
