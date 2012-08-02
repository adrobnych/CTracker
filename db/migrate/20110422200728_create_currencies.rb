class CreateCurrencies < ActiveRecord::Migration
  def self.up
    create_table :currencies, :id => false do |t|
      t.string :name
      t.string :code

      t.timestamps
      t.primary_key :code
    end
  end

  def self.down
    drop_table :currencies
  end
end
