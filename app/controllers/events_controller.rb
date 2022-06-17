class EventsController < ApplicationController
  def index
    if params[:q] && params[:q].compact_blank.present?
      @q = Event.ransack(search_params, activated_true: true)
      @title = "Search Result"
    else
      @q = Event.ransack(activated_true: true)
      @title = "All events"
    end
    @events = @q.result.paginate(page: params[:page])
  end

  private

  def search_params
    params.require(:q).permit(:name_cont, :source_eq, :date_gteq, :date_lteq)
  end
end
