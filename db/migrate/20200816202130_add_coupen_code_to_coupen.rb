class AddCoupenCodeToCoupen < ActiveRecord::Migration[6.0]
  def change
    add_column :coupens, :coupen_code, :string, null: false
    add_index :coupens, :coupen_code, unique: true
  end
end
