require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  test "#index should be success" do
    get events_path, headers: @stubbed_header, xhr: true
    assert_response :success
  end

  test "#index should return correct events when query has event name" do
    event1 = create(:event)
    create(:event)

    get events_path, params: { q: { name_cont: event1.name } }, headers: @stubbed_header, xhr: true
    assert_response :success

    assert_select "table" do
      assert_select "tr" do
        assert_select "td:nth-child(1)", event1.date.to_s
        assert_select "td:nth-child(2)", event1.name
        assert_select "td:nth-child(3)", event1.source
      end
    end
  end
end
