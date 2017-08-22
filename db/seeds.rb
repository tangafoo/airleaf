# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = {}
user['password'] = 'asdf'

ActiveRecord::Base.transaction do
  20.times do
    user['name'] = Faker::Name.name
    user['email'] = Faker::Internet.email
    user['country'] = Faker::Address.country
    User.create(user)
  end
end

# Seed Listings
listing = {}
uids = []
User.all.each { |u| uids << u.id }

ActiveRecord::Base.transaction do
  100.times do
    listing['title'] = Faker::App.name
    listing['description'] = Faker::Hipster.sentence
    listing['price'] = rand(80..500)
    listing['user_id'] = uids.sample

    Listing.create(listing)
  end
end
