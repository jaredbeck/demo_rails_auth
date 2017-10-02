class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.timestamps null: false
    end
  end
end
