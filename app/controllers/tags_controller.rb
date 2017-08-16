class TagsController < ApplicationController
  def index
    @listing = Listing.find(params[:listing_id])
  end

  def edit
    @tag_edit = Tag.find(params[:tag_id])
  end

  def update
  end

  def destroy
    @listing = Listing.find(params[:id])
    @tag_delete = @listing.listing_tags.find_by(tag_id: params[:tag_id])
    @tag_delete.destroy
    redirect_to '/'
  end

  private
  def default_tags
    @def_tags = ["Smoking", "Internet", "Parking", "Heating", "Pets", "Balcony"]
  end

end
