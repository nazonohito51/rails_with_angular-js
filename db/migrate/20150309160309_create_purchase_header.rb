class CreatePurchaseHeader < ActiveRecord::Migration
  def change
    create_table :purchase_headers do |t|
      t.integer :amount

      t.timestamps null: false
    end

    create_table :purchase_details do |t|
      t.integer :purchase_header_id, null: false
      t.string :name
      t.integer :price
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
