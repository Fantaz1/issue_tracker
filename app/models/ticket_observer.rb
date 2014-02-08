class TicketObserver < ActiveRecord::Observer
  def after_create(ticket)
    Mailer.ticket_created(ticket).deliver
  end
end
