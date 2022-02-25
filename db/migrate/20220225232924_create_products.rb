class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price, precision: 10, scale: 4, default: 0
      t.timestamps

      t.index %i[name], unique: true
    end
  end
end
