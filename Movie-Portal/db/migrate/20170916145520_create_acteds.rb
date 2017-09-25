class CreateActeds < ActiveRecord::Migration[5.1]
  def change
    create_table :acteds do |t|
      t.integer :mid 
      t.integer :cid

      t.timestamps
    end
  end
end
