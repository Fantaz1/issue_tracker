class AddCustomerNameAndEmailToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :customer_name, :string
    add_column :tickets, :customer_email, :string
  end
end
