require 'spec_helper'

describe Ticket do
  context "unique token" do
    let(:ticket){ FactoryGirl.create(:ticket) }

    it "generate referance string in format: ABC-123-ABC-123-ABC" do
      expect(ticket.token).to match(/\A[A-Z]{3}-\d{3}-[A-Z]{3}-\d{3}-[A-Z]{3}\z/)
    end

    it "generate random string" do
      tickets = FactoryGirl.create_list(:ticket, 5)
      tokens = tickets.map(&:token)

      expect(tokens.length).to eq(tokens.uniq.length)
    end
  end
end
