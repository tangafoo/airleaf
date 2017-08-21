class CreateListings < ActiveRecord::Migration[5.1]
  def change
    create_table :listings do |t|
      t.string :title
      t.text :description
      t.integer :price
      t.string :listing_picture
      t.json :gallery
      t.boolean :verification, default: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
