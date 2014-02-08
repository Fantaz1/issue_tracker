class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :user_id
      t.string :subject
      t.string :department
      t.text :body
      t.string :state

      t.timestamps
    end

    add_index :tickets, :user_id
  end
end
