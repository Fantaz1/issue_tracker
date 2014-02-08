require 'spec_helper'

describe Ticket do
  context "unique reference" do
    let(:ticket){ FactoryGirl.create(:ticket) }

    it "generate referance string in format: ABC-123-ABC-123-ABC" do
      expect(ticket.reference).to match(/\A[A-Z]{3}-\d{3}-[A-Z]{3}-\d{3}-[A-Z]{3}\z/)
    end

    it "generate random string" do
      tickets = FactoryGirl.create_list(:ticket, 5)
      references = tickets.map(&:reference)

      expect(references.length).to eq(references.uniq.length)
    end
  end
end
