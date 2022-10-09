class CreateDayCurrencies < ActiveRecord::Migration[7.0]
  def change
    create_table :day_currencies do |t|
      t.integer :day_id
      t.integer :currency_id
    end
  end
end
