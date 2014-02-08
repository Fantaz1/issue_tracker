module TicketsHelper
  def history_changes(ticket_version)
    changes = (ticket_version.reify.changed & ['user_id', 'status']).map do |key|
      if key == 'user_id'
        "Ticket was assigned to #{ticket_version.reify.user.name}" 
      else
        "Status was changed to '#{t("tickets.statuses.#{ticket_version.reify.status}")}'"
      end
    end

    "#{ticket_version.created_at.strftime('%m/%d/%Y %H:%M')}: #{changes.join(' and ')}"
  end
end
