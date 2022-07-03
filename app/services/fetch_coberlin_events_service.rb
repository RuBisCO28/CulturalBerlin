require "open-uri"
require "nokogiri"

class FetchCoberlinEventsService
  class RegisterCoberlinEventsError < StandardError; end

  SITE_URL = "https://co-berlin.org".freeze
  CALENDER_URL = "https://co-berlin.org/en/program/calendar".freeze
  SITE_NAME = "co-berlin".freeze

  def initialize
    @latest_event_date = Event.where(source: SITE_NAME).order(:date).map(&:date).last
  end

  def execute
    html = URI.parse(CALENDER_URL).open.read
    doc = Nokogiri::HTML.parse(html)
    doc.css(".views-row").each do |th|
      name = th.css("h2").text.strip
      url =  SITE_URL + th.css("a").attribute("href").value
      dt = th.css(".date-display-range").text.strip
      if dt.include?("–")
        arr = dt.split
        dt_fmt = Date.strptime("#{arr[1]} #{arr[2]} #{arr[7]}", "%b %d %Y")
      else
        dt_fmt = Date.strptime(dt, "%a, %b %d, %Y")
      end

      if @latest_event_date.before?(dt_fmt)
        event = Event.create!(name:, date: dt_fmt, source: SITE_NAME, url:)
        raise RegisterCoberlinEventsError if event.blank?
      end
    end
  end
end
