class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.integer :uid
      t.integer :mid
      t.integer :cid

      t.timestamps
    end
  end
end
