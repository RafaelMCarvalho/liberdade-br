# -*- encoding : utf-8 -*-
module ApplicationHelper
  def configuration
    @configuration ||= Configuration.first
  end

  def smart_truncate string, length
    truncate(strip_tags(string), :length => length,
      :separator => ' ').html_safe
  end
end
