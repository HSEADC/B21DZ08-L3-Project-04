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
end
