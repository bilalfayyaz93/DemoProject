class AddPriceToSoldProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :sold_products, :price, :integer, null: false
  end
end
