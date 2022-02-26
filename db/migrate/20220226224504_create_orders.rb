class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :user
      t.integer :state, default: 0
      t.decimal :amount, precision: 14, scale: 4, default: 0
      t.decimal :discount, precision: 10, scale: 4, default: 0
      t.timestamps

      t.index %i[user_id state]
    end
  end
end
