class EventsController < ApplicationController
	def index
		@event = FacebookEvent.search(params[:search]) if params[:search]
		@event = FacebookEvent.new if @event.nil? or !@event
	end

	def create
		flash[:notice]= "Event Created"
		redirect_to events_path
	end
end
