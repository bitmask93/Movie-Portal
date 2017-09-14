class CreateCasts < ActiveRecord::Migration[5.1]
  def change
    create_table :casts do |t|
      t.string :fname
      t.string :lname
      t.string :dob
      t.string :image
      t.string :note

      t.timestamps
    end
  end
end
