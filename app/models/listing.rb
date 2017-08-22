class Listing < ApplicationRecord
  belongs_to :user
  has_many :listing_tags, dependent: :destroy
  has_many :tags, through: :listing_tags
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true, uniqueness: true
  validates :price, presence: true
  has_many :bookings, dependent: :destroy
  mount_uploader :listing_picture, ListingPictureUploader
  mount_uploaders :gallery, GalleryUploader


      def self.search(search)
        @tag_finder = Tag.where('tag ILIKE ?', '%' + search + '%')
        if @tag_finder.nil?
        else
        @listing = Listing.joins(:listing_tags).where('tag_id IN (?)', @tag_finder.ids)
        end
        return @listing
      end

      def self.city_search(search)
        @listing = Listing.where('city ILIKE ?', '%' + search + '%')
        if @listing.nil?
          flash[:notice] = "Sorry, no listings could be found"
        else
          return @listing
        end
      end

      def self.search_dates(date_uno, date_dos)
        @counter = Array.new
        @booking = Booking.all.each do |b|
          if (Date.strptime(b.start_date, '%m/%d/%Y')..Date.strptime(b.end_date, '%m/%d/%Y')).include?(Date.strptime(date_uno, '%Y-%m-%d')) || (Date.strptime(b.start_date, '%m/%d/%Y')..Date.strptime(b.end_date, '%m/%d/%Y')).include?(Date.strptime(date_dos, '%Y-%m-%d'))
          else
            @counter << b.listing_id
          end
        end
        @listing = Listing.where(id: @counter)
        if @listing.nil?
          flash[:notice] = "Sorry, no listings could be found"
        else
          return @listing
        end
      end

      def tag_array
        @array = Array.new
        @read = ListingTag.where(listing_id: self.id)
        @read.each do |tag_column|
          @tagger = Tag.find_by(id: tag_column.tag_id)
          @array << @tagger.tag
        end
        return @array
      end

      def tag_array=(params)
        params -= [""]
        params.each do |tag_name|
            self.tags << Tag.find_or_create_by(tag: tag_name)
        end
      end

      def tag_text
      end

      def tag_text=(pars)
        @add = create_tags(pars)
        @add.each do |i|
          if self.tags.where(tag: i).count >= 1
          else
            self.tags << Tag.find_or_create_by(tag: i)
          end
        end
      end

      private

      def create_tags(text)
        text.gsub!(/\s+/,"")
        text = text.split(",")
      end

end
