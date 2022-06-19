require "open-uri"
require "nokogiri"

class FetchWorker
  include Sidekiq::Worker

  sidekiq_options queue: :fetch

  BERGHAIN_URL = "https://www.berghain.berlin".freeze
  BERGHAIN_CALENDER_URL = "https://www.berghain.berlin/en/program".freeze
  COBERLIN_URL = "https://co-berlin.org".freeze
  COBERLIN_CALENDER_URL = "https://co-berlin.org/en/program/calendar".freeze

  def perform(*_args)
    # fetch_berghain_events
    fetch_coberlin_events
  end

  private

  def fetch_berghain_events
    html = URI.parse(BERGHAIN_CALENDER_URL).open.read
    doc = Nokogiri::HTML.parse(html)
    doc.css(".upcoming-event").each do |th|
      name = th.css("h2").text.strip
      dt = th.css("p").css("span").text.strip
      dt_fmt = Date.strptime(dt, "%d.%m.%Y")
      src = "berghain"
      url = BERGHAIN_URL + th.attribute("href").value

      result = Event.find_by(name:, date: dt_fmt, source: src, url:)
      Event.create!(name:, date: dt_fmt, source: src, url:) if result.nil?
    end
  end

  def fetch_coberlin_events
    html = URI.parse(COBERLIN_CALENDER_URL).open.read
    doc = Nokogiri::HTML.parse(html)
    doc.css(".views-row").each do |th|
      name = th.css("h2").text.strip
      url =  COBERLIN_URL + th.css("a").attribute("href").value
      src = "co-berlin"
      dt = th.css(".date-display-range").text.strip
      if dt.include?("–")
        arr = dt.split
        dt_fmt = Date.strptime("#{arr[1]} #{arr[2]} #{arr[7]}", "%b %d %Y")
      else
        dt_fmt = Date.strptime(dt, "%a, %b %d, %Y")
      end

      result = Event.find_by(name:, date: dt_fmt, source: src, url:)
      Event.create!(name:, date: dt_fmt, source: src, url:) if result.nil?
    end
  end
end
