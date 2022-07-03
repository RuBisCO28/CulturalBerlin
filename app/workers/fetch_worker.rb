require "open-uri"
require "nokogiri"

class FetchWorker
  include Sidekiq::Worker

  sidekiq_options queue: :fetch

  def perform(*_args)
    FetchBerghainEventsService.new.execute
    FetchCoberlinEventsService.new.execute
  end
end
