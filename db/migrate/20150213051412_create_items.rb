class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.integer :price
      t.boolean :on_sale, default: false, null: false

      t.timestamps null: false
    end
  end
end
