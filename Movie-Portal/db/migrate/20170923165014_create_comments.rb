class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.integer :uid
      t.integer :mid
      t.string :comment
      t.integer :reports, :default=>0

      t.timestamps
    end
  end
end
