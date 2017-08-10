class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.text :tag, array: true, default: []
      t.text :tag_text, array: true, default: []
      t.references :listing, foreign_key: true

      t.timestamps
    end
  end
end
