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
require "test_helper"

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
