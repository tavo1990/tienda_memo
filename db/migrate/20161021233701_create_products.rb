class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :reference
      t.decimal :precio
      t.integer :quantity
      t.string :brand
      t.text :description

      t.timestamps
    end
  end
end
