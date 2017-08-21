class ListingsController < ApplicationController

  def index
    @listing = Listing.all.paginate(:page => params[:page], :per_page => 20).order("created_at ASC")
    if params[:search]
      @listing_ids = Listing.search(params[:search]).uniq
      @listing = Listing.where(id: @listing_ids.map(&:id)).paginate(:page => params[:page], :per_page => 20).order("created_at ASC")
    end
  end

  before_action :require_login

  def new
    @listing = Listing.new
  end

  def create
    @listing = current_user.listings.new(listing_params)
    if @listing.save
      redirect_to '/'
    else
      render 'new'
    end
  end

  def show
    @listing = Listing.find(params[:id])
    @booking = @listing.bookings.new
    @dates = Booking.joins(:listing).where(listing_id: @listing.id)
    @bookings = Array.new
    @dates.each do |start_end|
      @bookings << start_end.start_date
      @bookings << start_end.end_date
    end
    @bookings = @bookings.first
  end

  def verify
    @listing = Listing.find(params[:listing_id])
    @listing.update(verification: true)
    redirect_to 'show'
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def update
    @listing = Listing.find(params[:id])
    renew_checks(@listing)
    if @listing.update(listing_params)
      redirect_to '/'
    else
      redirect_to 'edit'
    end
  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
    redirect_to '/'
  end

  private
  def listing_params
    params.require(:listing).permit(:title, :description, :price, :tag_text, :listing_picture, :remote_image_url, gallery: [], tag_array: [])
  end

  def renew_checks(list)
    default_tags.each do |def_tag|
      @tag_id = Tag.find_by(tag: def_tag)
      @renew = list.listing_tags.find_by(tag_id: @tag_id.id)
      if @renew.nil?
      else
      @renew.destroy
      end
    end
  end

end
