class ListingsController < ApplicationController
  def index
    @listing = Listing.all
  end

  before_action :require_login

  def new
    @listing = Listing.new
    @tag = @listing.tags.new
  end

  def create
    @listing = current_user.listings.new(listing_params)
    if @listing.save
      @listing.tags.create do |t|
        t.tag += params[:tag][:tag] || []
        t.tag += create_tags(params[:tag][:tag_text] || [])
      end
      redirect_to '/'
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:user_id])
    @listing = Listing.find(params[:id])
    @tag = Tag.find_by(listing_id: params[:id])
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

  def create_tags(text)
    text.map! do |i|
      i.gsub(/\s+/,"")
    end
  end

  def make_tag_unique(exist, new_input)
    exist - new_input
  end
end
