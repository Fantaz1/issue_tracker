require 'spec_helper'

feature "As a customer I want be able to add new tickets and see my already exist tickets" do
  let!(:ticket_attr){ FactoryGirl.attributes_for(:ticket)}

  background do
    visit root_path

    find('.jumbotron a', text: 'Add new ticket').click

    within "#new_ticket" do
      fill_in "Customer email", with: ticket_attr[:customer_email]
      fill_in "Customer name", with: ticket_attr[:customer_name]
      fill_in "Subject", with: ticket_attr[:subject]
      fill_in "Department", with: ticket_attr[:department]
      fill_in "Body", with: ticket_attr[:body]

      find('[type=submit]').click
    end
  end

  scenario "visit root page and add new ticket" do
    expect(page).to have_content "Ticket was successfully created."
  end

  scenario "customer was redirected to ticket page from mail link" do
    email = ActionMailer::Base.deliveries.last
    lnk = email.body.raw_source.scan(/<a.+?href="(.+?)"/).flatten[0]
    lnk = (lnk.to_s.gsub "http://issue_traker.dev", "")

    visit lnk

    expect(find_field("Customer email").value).to eq(ticket_attr[:customer_email])
    expect(find_field("Customer name").value).to eq(ticket_attr[:customer_name])
    expect(find_field("Subject").value).to eq(ticket_attr[:subject])
    expect(find_field("Department").value).to eq(ticket_attr[:department])
    expect(find_field("Body").value).to eq(ticket_attr[:body])
  end
end