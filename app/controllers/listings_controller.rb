class ListingsController < ApplicationController
  def index
    @listing = Listing.all
    if params[:search]
      @listing = Listing.search(params[:search])
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
    params.require(:listing).permit(:title, :description, :price, :tag_text, tag_array: [])
  end

  def default_tags
    @def_tags = ["Smoking", "Internet", "Parking", "Heating", "Pets", "Balcony"]
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
