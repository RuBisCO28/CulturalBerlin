require "open-uri"
require "nokogiri"

class FetchBerghainEventsService
  class RegisterBerghainEventsError < StandardError; end

  SITE_URL = "https://www.berghain.berlin".freeze
  CALENDER_URL = "https://www.berghain.berlin/en/program".freeze
  SITE_NAME = "berghain".freeze

  def initialize
    @latest_event_date = Event.where(source: SITE_NAME).order(:date).map(&:date).last
  end

  def execute
    html = URI.parse(CALENDER_URL).open.read
    doc = Nokogiri::HTML.parse(html)
    doc.css(".upcoming-event").each do |th|
      name = th.css("h2").text.strip
      dt = th.css("p").css("span").text.strip
      dt_fmt = Date.strptime(dt, "%d.%m.%Y")
      url = SITE_URL + th.attribute("href").value

      if @latest_event_date.before?(dt_fmt)
        event = Event.create!(name:, date: dt_fmt, source: SITE_NAME, url:)
        raise RegisterBerghainEventsError if event.blank?
      end
    end
  end
end
