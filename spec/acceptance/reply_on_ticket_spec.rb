require 'spec_helper'

feature "As a user I want be able to see all posted tickets and reply on them" do
  let!(:user){ FactoryGirl.create(:user, name: 'evgeniy', password: '12345678') }
  let!(:tickets){ FactoryGirl.create_list(:ticket, 3)}

  background do
    sign_in user
    click_link 'Tickets'
    click_link 'All tickets'
  end

  scenario "open tickets page and see all tickets" do
    tickets.each do |ticket|
      expect(page).to have_selector('tr', text: ticket.subject)
    end
  end

  scenario "open a ticket" do
    ticket = tickets.first
    find('tr', text: ticket.subject).click_link('Show')

    expect(page).to have_content(ticket.customer_name)
    expect(page).to have_content(ticket.customer_email)
    expect(page).to have_content(ticket.subject)
    expect(page).to have_content(ticket.department)
    expect(page).to have_content(ticket.body)
  end

  scenario "reply on ticket" do
    ticket = tickets.first
    find('tr', text: ticket.subject).click_link('Show')

    within "#reply_form" do
      fill_in "ticket_response", with: 'Response'
      find('[type=submit]').click
    end

    expect(page).to have_content 'Your response was sent.'
  end

  scenario "change ticket status" do
    ticket = tickets.first
    find('tr', text: ticket.subject).click_link('Show')

    within "#reply_form" do
      select "On Hold", from: 'ticket_status'
      find('[type=submit]').click
    end

    expect(page).to have_content 'Status: On Hold'
  end

  scenario "assign to user" do
    ticket = tickets.first
    find('tr', text: ticket.subject).click_link('Show')

    within "#reply_form" do
      select user.name, from: 'ticket_user_id'
      find('[type=submit]').click
    end

    expect(page).to have_content "Assigned to: #{user.name}"
  end
end