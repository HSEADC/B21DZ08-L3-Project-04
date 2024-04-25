class DropAttachments < ActiveRecord::Migration[7.0]
  def change
    drop_table :attachments
  end
end
