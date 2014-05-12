class AddVisibilityToProducts < ActiveRecord::Migration
  def change
    add_column :products, :visible, :boolean
  end
end
