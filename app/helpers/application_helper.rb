module ApplicationHelper
    def formatted_date(date)
        current_year = Time.now.year
    date_year = date.year

    russian_months = %w[января февраля марта апреля мая июня июля августа сентября октября ноября декабря]

    format_string = if date_year == current_year
                      "%e #{russian_months[date.month - 1]}"
                    else
                      "%e #{russian_months[date.month - 1]} %Y"
                    end

    date.strftime(format_string)
    end
    
    def russian_pluralize(count, one, few, many)
      if count == 0
        return "0 #{many}"
      elsif count % 10 == 1 && count % 100 != 11
        return "#{count} #{one}"
      elsif [2, 3, 4].include?(count % 10) && ![12, 13, 14].include?(count % 100)
        return "#{count} #{few}"
      else
        return "#{count} #{many}"
      end
    end

    def random_logo_class
      session[:used_logos] ||= []
  
      logos = %w[MidSummer1 MidSummer2 MidSummer3 MidSummer4 MidSummer5]
      available_logos = logos - session[:used_logos]
      selected_logo = available_logos.sample
  
      session[:used_logos] << selected_logo
  
      session[:used_logos] = [] if session[:used_logos].length == logos.length
  
      selected_logo
    end
end
