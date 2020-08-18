class AddCoupenCodeToCoupen < ActiveRecord::Migration[6.0]
  def change
    add_index :coupens, :coupen_code, unique: true
  end
end
