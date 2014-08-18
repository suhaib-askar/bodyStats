module ApplicationHelper

  def full_title(page_title)
    base_title = "Body Stats"
    return base_title if page_title.empty?
    "#{base_title} | #{page_title}"
  end
  
  def print_errors
    unless flash.empty?
      message = nil
      flash.each do |key, value|
        message = content_tag :div, class: "alert alert-#{key}" do
          concat(content_tag :a, "&times".html_safe, href: "#", class: "close")
          concat(content_tag :center, (content_tag :strong, value.is_a?(Array) ? value.join(", ") : value ), '')
        end
      end
      message
    end
  end
      #   .message
      #     %div{ class: "alert-message #{key}" }
      #       %a.close{ href: "#" } &times
      #       %center
      #         %strong= value

      # flash.each do |key, value|
      #   key = 'success' if key == 'notice'
      #   key = 'danger' if key == 'alert'
      #   return content_tag :div, value, class: "alert alert-#{key} container"

  def fl(text)
    text.mb_chars.capitalize.to_s
  end
end
