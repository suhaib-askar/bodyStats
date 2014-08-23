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

  def fl(text)
    text.mb_chars.capitalize.to_s
  end

  def no_header_footer!
    if signed_in?
      @tuktuk = "boxes"
      @no_header_footer = true 
    end
  end


  def my(render)
    render unless @no_header_footer
  end

  def unit(unit_id)
    Unit.find(unit_id).send("short_#{I18n.locale}")
  end
end
