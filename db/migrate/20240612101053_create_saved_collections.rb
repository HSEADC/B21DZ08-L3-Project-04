class CreateSavedCollections < ActiveRecord::Migration[7.0]
  def change
    create_table :saved_collections do |t|
      t.references :user, null: false, foreign_key: true
      t.references :collection, null: false, foreign_key: true

      t.timestamps
    end
  end
end
