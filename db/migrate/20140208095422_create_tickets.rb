class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :user_id
      t.string :subject
      t.string :department
      t.text :body
      t.string :status, default: 'waiting_for_staff'

      t.timestamps
    end

    add_index :tickets, :user_id
  end
end
