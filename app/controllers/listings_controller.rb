class ListingsController < ApplicationController
  def index
    @listing = Listing.all
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
    @user = User.find(params[:user_id])
    @listing = Listing.find(params[:id])
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def update
    @listing = Listing.find(params[:id])

    if @listing.update(listing_params)
      redirect_to 'show'
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
    params.require(:listing).permit(:title, :description, :price)
  end
end
