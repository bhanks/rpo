class ChangeVisibilityDefault < ActiveRecord::Migration
  def change
    change_column :products, :visible, :boolean, default: false
  end
end
