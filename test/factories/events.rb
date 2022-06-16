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
  end
end
