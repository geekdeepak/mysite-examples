puts "***facebook event updates***"

t1 = Time.now
puts "================"
puts Time.now.strftime("%Y%m%d-%H%M%S") + " : " + __FILE__ + " starting..."

puts "\ngrabbing file lock....."
if File.new(__FILE__).flock(File::LOCK_EX | File::LOCK_NB) == false
  puts "*** can't lock file, another instance of script running?  exiting"
  exit 1
end
puts "obtained file lock for event updates... starting facebook api calls...\n"

allevents = FacebookEvent.find(:all, :conditions => [ "end_time > ?", Time.now ])
puts "Total events found => "+allevents.count.to_s
event_counter = 0
config = YAML::load(File.open("#{Rails.root}/config/facebook.yml"));
gscc_app = FbGraph::Application.new(config['production']['app_id'])
access_token = gscc_app.get_access_token(config['production']['client_secret'])
allevents.each do |e|
	event_counter +=1
	puts event_counter.to_s+"\n"
	begin
		ie = FbGraph::Event.new(e.identifier, :access_token => access_token).fetch;
		if ie
			link = e.event_url || ""
			puts 'adding event entry for '+e.name
			puts link 
			e.event_updates.create(:attending=>ie.attending.count,:maybe=>ie.maybe.count,:invited=>ie.invited.count)
			puts 'event entry added'
		else
			puts "event #{e.name} not found ..."
			#e.delete
		end
	rescue FbGraph::InvalidRequest
		puts "corrupt event #{e.name}"
	rescue HTTPClient::ReceiveTimeoutError
		puts 'recieve timout error'
	rescue HTTPClient::ConnectTimeoutError
		puts 'send timeout error'
	rescue #Exception => e
  		#puts e.message
		puts 'error occured'
	end
end

t2 = Time.now
puts Time.now.strftime("%Y%m%d-%H%M%S") + " : " + __FILE__ + " finished  #{t2 - t1} secs"
puts "================"