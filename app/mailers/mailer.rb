class Mailer < ActionMailer::Base
  default from: "from@example.com"

  def ticket_created(ticket)
    @ticket = ticket
    mail(to: ticket.customer_email, subject: 'Ticket was created')
  end
end
