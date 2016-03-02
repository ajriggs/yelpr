module ApplicationHelper

  def date_string(timestamp:)
    timestamp.strftime("%e %b %Y")
  end

end
