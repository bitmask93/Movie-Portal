class CreateDirects < ActiveRecord::Migration[5.1]
  def change
    create_table :directs do |t|
      t.integer :mid
      t.integer :did

      t.timestamps
    end
  end
end
