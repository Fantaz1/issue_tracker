class Ticket < ActiveRecord::Base
  has_paper_trail

  before_validation :set_reference, on: :create

  belongs_to :user

  validates_presence_of :reference
  validates_presence_of :customer_email
  validates_presence_of :customer_name
  validates_presence_of :body
  validates_presence_of :subject
  validates_presence_of :department

private
  def set_reference
    begin
      self.reference = (1..5).map{|i| generate_code(i)}.join('-')
    end while(Ticket.where(reference: self.reference).exists?)
  end

  def generate_code(i)
    array = (i.odd? ? ('A'..'Z') : (1..9)).to_a
    (1..3).map{ array.sample }.join
  end
end
