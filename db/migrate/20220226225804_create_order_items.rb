class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.references :order
      t.bigint :itemable_id
      t.string :itemable_type
      t.integer :quantity, default: 0
      t.timestamps

      t.index %i[order_id itemable_id itemable_type], unique: true
    end
  end
end
