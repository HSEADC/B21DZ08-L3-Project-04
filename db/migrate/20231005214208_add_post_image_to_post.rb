class AddPostImageToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :post_image, :string
  end
end
