require 'spec_helper'

feature "As a user I want be able to find tickets by different params" do
  let(:user){ FactoryGirl.create(:user)}

  let!(:waiting_for_staff_ticket){ FactoryGirl.create(:ticket, status: 'waiting_for_staff')}
  let!(:waiting_for_customer_ticket){ FactoryGirl.create(:ticket, status: 'waiting_for_customer')}
  let!(:on_hold_ticket){ FactoryGirl.create(:ticket, status: 'on_hold')}
  let!(:completed_ticket){ FactoryGirl.create(:ticket, status: 'completed')}

  background do
    sign_in user
  end

  scenario "search for ticket by token" do
    within "#search-form" do
      fill_in "q", with: waiting_for_staff_ticket.token
      click_button 'Submit'
    end

    expect(find('.table tbody')).to have_css('tr', count: 1)
    expect(find('tbody tr')).to have_content waiting_for_staff_ticket.subject
  end

  scenario "search for ticket by subject" do
    within "#search-form" do
      fill_in "q", with: waiting_for_staff_ticket.subject
      click_button 'Submit'
    end

    expect(find('.table tbody')).to have_selector 'tr', count: 1
    expect(find('tbody tr')).to have_content waiting_for_staff_ticket.subject
  end

  scenario "open all unassigned tickets" do
    click_link 'Tickets'
    click_link 'New unassigned tickets'

    expect(find('.table tbody')).to have_selector 'tr', count: 1
    expect(find('tbody tr')).to have_content waiting_for_staff_ticket.subject
  end

  scenario "open all 'Open tickets'" do
    click_link 'Tickets'
    click_link 'Open Tickets'

    expect(find('.table tbody')).to have_selector 'tr', count: 1
    expect(find('tbody tr')).to have_content waiting_for_customer_ticket.subject
  end

  scenario "open all 'On hold' tickets" do
    click_link 'Tickets'
    click_link 'On hold Tickets'

    expect(find('.table tbody')).to have_selector 'tr', count: 1
    expect(find('tbody tr')).to have_content on_hold_ticket.subject
  end

  scenario "open all closed tickets" do
    click_link 'Tickets'
    click_link 'Closed Tickets'

    expect(find('.table tbody')).to have_selector 'tr', count: 1
    expect(find('tbody tr')).to have_content completed_ticket.subject
  end
end