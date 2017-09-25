class CreateRates < ActiveRecord::Migration[5.1]
  def change
    create_table :rates do |t|
      t.integer :mid
      t.integer :uid
      t.integer :rating

      t.timestamps
    end
  end
end
