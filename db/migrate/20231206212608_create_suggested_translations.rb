class CreateSuggestedTranslations < ActiveRecord::Migration[7.0]
  def change
    create_table :suggested_translations do |t|
      t.integer :user_id
      t.integer :post_id
      t.string :language
      t.text :body

      t.timestamps
    end
  end
end
