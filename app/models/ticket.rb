class Ticket < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search, against: [:token, :customer_email, :customer_name, :body, :subject, :department, :status]

  attr_accessor :response
  has_paper_trail only: [:status, :user_id], on: [:update]

  before_validation :set_token, on: :create

  belongs_to :user

  STATUSES = %w(waiting_for_staff waiting_for_customer on_hold cancelled completed)

  validates_presence_of :token
  validates_presence_of :customer_email
  validates_presence_of :customer_name
  validates_presence_of :body
  validates_presence_of :subject
  validates_presence_of :department
  validates_inclusion_of :status, :in => STATUSES

  def to_param
    self.token
  end

private
  def set_token
    begin
      self.token = (1..5).map{|i| generate_code(i)}.join('-')
    end while(Ticket.where(token: self.token).exists?)
  end

  def generate_code(i)
    array = (i.odd? ? ('A'..'Z') : (1..9)).to_a
    (1..3).map{ array.sample }.join
  end
end
