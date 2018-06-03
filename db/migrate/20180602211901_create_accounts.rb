class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :email_id
      t.string :password
      t.integer :client, default: 0
      t.belongs_to :user

      t.timestamps
    end
  end
end
