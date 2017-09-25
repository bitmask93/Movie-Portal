class CreateDirectors < ActiveRecord::Migration[5.1]
  def change
    create_table :directors do |t|
      t.string :fname
      t.string :lname
      t.string :image
      t.date :dob
      t.string :note

      t.timestamps
    end
  end
end
