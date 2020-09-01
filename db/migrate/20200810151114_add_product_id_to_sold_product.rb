class AddProductIdToSoldProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :sold_products, :product_id, :integer
  end
end
