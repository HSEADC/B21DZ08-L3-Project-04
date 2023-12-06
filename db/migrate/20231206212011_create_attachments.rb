class CreateAttachments < ActiveRecord::Migration[7.0]
  def change
    create_table :attachments do |t|
      t.string :type
      t.integer :post_id
      t.string :url

      t.timestamps
    end
  end
end
