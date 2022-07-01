class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
