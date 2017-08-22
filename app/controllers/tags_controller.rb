class TagsController < ApplicationController
  def index
    @listing = Listing.find(params[:listing_id])
  end

  def edit
    @listing = Listing.find(params[:id])
    @tag_edit = Tag.find(params[:tag_id])
  end

  def update
    @listing = Listing.find(params[:id])
    @tag_edit = @listing.tags.find(params[:tag_id])
    if params[:tag][:tag] == ""
      flash[:notice] = "Please do not leave tag field blank"
      render 'edit'
    else
      @tag_edit.update(tag: perfect_extra_tags(params[:tag][:tag]))
      redirect_to 'index'
    end
  end

  def destroy
    @listing = Listing.find(params[:id])
    @tag_delete = @listing.listing_tags.find_by(tag_id: params[:tag_id])
    @tag_delete.destroy
    redirect_to '/'
  end

  private
  def perfect_extra_tags(text)
    text.gsub!(/\s+/,"")
  end

end
