class CreateCurrencies < ActiveRecord::Migration[7.0]
  def change
    create_table :currencies do |t|
      t.string :code
      t.integer :exchange_rate
    end
  end
end
