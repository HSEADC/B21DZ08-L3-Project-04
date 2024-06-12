class CreateCollectionsPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :collections_posts do |t|
      t.references :collection, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
