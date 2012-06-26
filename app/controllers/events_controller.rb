class EventsController < ApplicationController
	def index
		if params[:search]
			@event = FacebookEvent.search(params[:search]) if params[:search]
			flash[:error]="Event already in database" if @event #if event found current events database
			if @event.nil?
				@event = OldFacebookEvent.find_by_identifier(params[:search]) 
				flash[:error]="Event already in database and passed" if @event
			end			#if event found in old events database
			if @event.nil?
				# else create a new event object and fetch data from fb
				begin
					config = YAML::load(File.open("#{Rails.root}/config/facebook.yml"));
					gscc_app = FbGraph::Application.new(config['production']['app_id'])
					access_token = gscc_app.get_access_token(config['production']['client_secret'])
					ie = FbGraph::Event.new(params[:search], :access_token => access_token).fetch
					@event = FacebookEvent.new( :name => ie.name, :start_time => ie.start_time, :end_time => ie.end_time, 
		            :location => ie.location, :description => ie.description, :updated_time => ie.updated_time, 
		            :identifier => ie.identifier, :picture => ie.picture,:small_picture=>ie.picture+'?type=small',
		            :normal_picture=>ie.picture+'?type=normal',:event_url=>"https://www.facebook.com/events/"+ie.identifier )
					flash.discard(:error)
					flash[:notice]="New Event"
				rescue
					flash.discard(:notice)
					flash[:error] = "May be not a valid event id or try again"
					@event = FacebookEvent.new
				end
			end
		else
			@event = FacebookEvent.new
		end
	end

	def create
		@event = FacebookEvent.new(params[:facebook_event])
		@event.save
		redirect_to events_path
	end
end
