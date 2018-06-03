class CreateEmails < ActiveRecord::Migration[5.2]
  def change
    create_table :emails do |t|
      t.string :message_id
      t.string :from
      t.string :to
      t.text :subject
      t.text :html_body
      t.text :text_body
      t.datetime :date
      t.boolean :read, default: false
      t.belongs_to :account

      t.timestamps
    end
    add_index :emails, :message_id
  end
end
