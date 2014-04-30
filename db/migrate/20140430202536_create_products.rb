class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.string :subtitle
      t.text :description
      t.integer :display_order
      t.string :image
      t.boolean :featured

      t.timestamps
    end
  end
end
