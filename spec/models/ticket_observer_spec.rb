require 'spec_helper'

describe TicketObserver do
  before do
    ActionMailer::Base.deliveries.clear
  end

  it "send mail" do
    expect{
      FactoryGirl.create(:ticket)  
    }.to change(ActionMailer::Base.deliveries, :size).by(1)
  end

  it "send mail to custoemr" do
    ticket = FactoryGirl.create(:ticket)
    email = ActionMailer::Base.deliveries.last
    expect(email.to).to be_include(ticket.customer_email)
  end
end
