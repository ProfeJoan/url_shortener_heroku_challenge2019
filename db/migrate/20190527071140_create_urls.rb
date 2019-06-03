class CreateUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :urls do |t|
      t.text :original_url
      t.string :short_url
      t.text :title
      t.integer :visit_count
      t.string :date_shortened
      t.timestamps
    end
  end
end
