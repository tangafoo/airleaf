class TagsController < ApplicationController
  def edit
    @def_tag_id = Array.new
    @listing = Listing.find(params[:listing_id])
    @tag_text = @listing.listing_tags
    default_tags.each do |def_tag|
      index = Tag.find_or_create_by(tag: def_tag)
      @def_tag_id << index.id
    end
  end

  private
  def default_tags
    @def_tags = ["Smoking", "Internet", "Parking", "Heating", "Pets", "Balcony"]
  end

end
