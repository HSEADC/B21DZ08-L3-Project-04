class CreatePostsUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :posts_users do |t|
      t.integer :post_id
      t.integer :user_id

      t.timestamps
    end
  end
end
