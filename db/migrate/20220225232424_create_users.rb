class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.timestamps
      t.index %i[name], unique: true
    end
  end
end
