# == Schema Information
#
# Table name: events
#
#  id     :bigint           not null, primary key
#  date   :date             not null
#  name   :string           not null
#  source :string           not null
#  url    :string           not null
#
FactoryBot.define do
  factory :event do
    date { Time.zone.now.to_date }
    sequence(:name) { |n| "event_#{n}" }
    sequence(:source) { |n| "source_#{n}" }
    sequence(:url) { |n| "url_#{n}" }
  end
end
