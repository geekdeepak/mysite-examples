puts "***facebook event updates***"

t1 = Time.now
puts "================"
puts Time.now.strftime("%Y%m%d-%H%M%S") + " : " + __FILE__ + " starting..."

puts "\ngrabbing file lock....."
if File.new(__FILE__).flock(File::LOCK_EX | File::LOCK_NB) == false
  puts "*** can't lock file, another instance of script running?  exiting"
  exit 1
end
puts "obtained file lock... starting facebook api calls...\n"

allevents = FacebookEvent.find(:all, :conditions => [ "end_time > ?", Time.now ])
config = YAML::load(File.open("#{Rails.root}/config/facebook.yml"));
gscc_app = FbGraph::Application.new(config['production']['app_id'])
access_token = gscc_app.get_access_token(config['production']['client_secret'])
allevents.each do |e|	
	begin
		ie = FbGraph::Event.new(e.identifier, :access_token => access_token).fetch;
		if ie
			puts 'adding entry for '+e.name
			e.event_updates.create(:attending=>ie.attending.count,:maybe=>ie.maybe.count,:invited=>ie.invited.count)
			puts 'entry added'
		else
			puts "event #{e.name} not found deleting..."
			e.delete
		end
	rescue FbGraph::InvalidRequest
		puts "corrupt event #{e.name}"
	end
end

t2 = Time.now
puts Time.now.strftime("%Y%m%d-%H%M%S") + " : " + __FILE__ + " finished  #{t2 - t1} secs"
puts "================"