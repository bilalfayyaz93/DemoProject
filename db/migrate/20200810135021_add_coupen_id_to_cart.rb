class AddCoupenIdToCart < ActiveRecord::Migration[6.0]
  def change
    add_column :carts, :coupen_id, :integer
  end
end
