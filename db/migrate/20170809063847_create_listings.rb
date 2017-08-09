class CreateListings < ActiveRecord::Migration[5.1]
  def change
    create_table :listings do |t|
      t.string :listing_title
      t.text :listing_description
      t.integer :price
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
