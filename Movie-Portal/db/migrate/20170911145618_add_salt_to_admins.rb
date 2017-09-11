class AddSaltToAdmins < ActiveRecord::Migration[5.1]
  def change
    add_column :admins, :salt, :integer
  end
end
