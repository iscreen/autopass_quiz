class CreatePromotions < ActiveRecord::Migration[7.0]
  def change
    create_table :promotions do |t|
      t.string :type
      t.string :name
      t.datetime :start_date
      t.datetime :end_date
      t.references :product
      t.decimal :amount, precision: 12, scale: 4, default: 0
      t.integer :discount_percentage, default: 0
      t.decimal :discount_amount, precision: 6, scale: 4, default: 0
      t.integer :exceed_quantity, default: 0
      t.integer :taken_limitation, default: 0
      t.decimal :discount_amount_limitation, precision: 12, scale: 4, default: 0
      t.decimal :month_discount_amount_limitation, precision: 12, scale: 4, default: 0
      t.timestamps

      t.index [:type, :start_date, :end_date]
    end
  end
end
