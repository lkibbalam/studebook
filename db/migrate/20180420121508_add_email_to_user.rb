class AddEmailToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :email, :string, index: true, unique: true
    add_column :users, :password_digest, :string
  end
end
