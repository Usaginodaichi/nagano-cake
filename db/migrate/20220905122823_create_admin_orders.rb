class CreateAdminOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :admin_orders do |t|

      t.string :postal_code, null: false
      t.string :address, null: false
      t.string :name, null: false
      t.integer :shipping_cost, default: 800, null: false
      t.integer :total_payment, null: false
      t.integer :payment_method, null: false
      t.integer :status, null: false
      t.datetime :remember_created_at
      t.datetime :remember_updated_at

      t.timestamps
    end
  end
end
