class ChangeColumnTypeInPosts < ActiveRecord::Migration[7.0]
  def change
    change_column :posts, :place, :text
    change_column :posts, :people, :text
    change_column :posts, :source, :text
    change_column :posts, :context, :text
    change_column :posts, :remark, :text
  end
end
