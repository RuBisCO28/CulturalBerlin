require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  test "#index should be success" do
    create(:event)

    get events_path, headers: @stubbed_header, xhr: true
    assert_response :success
  end
end
