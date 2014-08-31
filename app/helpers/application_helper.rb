module ApplicationHelper

  def full_title(page_title)
    base_title = "BodyStats"
    return base_title if page_title.empty?
    "#{page_title} | #{base_title}"
  end
  
  def print_errors
    if flash.present? 
      message = nil
      flash.each do |key, value|
        if value.empty? 
          message = nil
        else
          message = content_tag :div, class: "alert alert-#{key}" do
            concat(content_tag :a, "&times".html_safe, href: "#", class: "close")
            concat(content_tag :center, (content_tag :strong, value.is_a?(Array) ? value.join(", ") : value ), '')
          end
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
    @units.map {|u| u[unit_id]}.compact[0]["short_#{I18n.locale}".to_sym]
  end

  def units
    @units = Unit.all.map { |u|  { u.id => {full_en: u.full_en, short_en: u.short_en, full_ru: u.full_ru, short_ru: u.short_ru} } } 
  end

  def percent(n1, n2)
    res = if n1.present? && n2.present?
      n1 = n1.to_f
      n2 = n2.to_f
      (n2/n1 - 1) * 100
    else
      0
    end
    res
  end

  def set_more_info(type, count)
    if type.present? && count.present?
      session[:type] =  "for_" + type
      session[:count] = count.to_i
    else
      session[:type] ||= :for_week
      session[:count] ||= 1
    end
  end

end
