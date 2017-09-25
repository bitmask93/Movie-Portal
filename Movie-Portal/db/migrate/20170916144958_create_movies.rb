class CreateMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :movies do |t|
      t.string :mn
      t.date :dor
      t.string :video
      t.integer :dur
      t.string :gen1
      t.string :gen2
      t.string :note
      t.string :photo
      t.integer :verify, :default=>0

      t.timestamps
    end
  end
end
