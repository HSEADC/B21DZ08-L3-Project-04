class SuggestedTranslations < ActiveRecord::Migration[7.0]
  def change
    drop_table :suggested_translations
  end
end
