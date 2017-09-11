class CreateAdmins < ActiveRecord::Migration[5.1]
  def change
    create_table :admins do |t|
      t.string :fname
      t.string :string
      t.string :lname
      t.string :string
      t.string :email
      t.string :string
      t.string :pass
      t.string :string

      t.timestamps
    end
  end
end
