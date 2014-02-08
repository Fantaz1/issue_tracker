class Mailer < ActionMailer::Base
  default from: "from@example.com"

  def ticket_created(ticket)
    @ticket = ticket
    mail(to: ticket.customer_email, subject: 'Ticket was created')
  end

  def response_added(ticket, response)
    @ticket = ticket
    @response = response
    mail(to: @ticket.customer_email, subject: 'You got response for your ticket')
  end
end
