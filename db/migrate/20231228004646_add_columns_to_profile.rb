class AddColumnsToProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :login, :string
  end
end
