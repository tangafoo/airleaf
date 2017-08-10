class ListingTag < ApplicationRecord
  belongs_to :tag
  belongs_to :listing
end
