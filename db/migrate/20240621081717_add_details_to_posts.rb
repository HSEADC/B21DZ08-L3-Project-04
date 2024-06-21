class AddDetailsToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :place, :string
    add_column :posts, :people, :string
    add_column :posts, :source, :string
    add_column :posts, :context, :string
    add_column :posts, :remark, :string
    add_column :posts, :recording_date, :date
  end
end
