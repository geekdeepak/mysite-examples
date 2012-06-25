puts "***moving old events***"

t1 = Time.now
puts "================"
puts Time.now.strftime("%Y%m%d-%H%M%S") + " : " + __FILE__ + " starting..."

puts "\ngrabbing file lock....."
if File.new(__FILE__).flock(File::LOCK_EX | File::LOCK_NB) == false
  puts "*** can't lock file, another instance of script running?  exiting"
  exit 1
end
puts "obtained file lock for event updates... starting facebook api calls...\n"

allevents = FacebookEvent.find(:all, :conditions => [ "end_time < ?", Time.now ])
puts "Old events found => "+allevents.count.to_s
config = YAML::load(File.open("#{Rails.root}/config/facebook.yml"));
gscc_app = FbGraph::Application.new(config['production']['app_id'])
access_token = gscc_app.get_access_token(config['production']['client_secret'])
allevents.each do |e|
	puts "moving "+ e.name + " to old events"
	oldevent = OldFacebookEvent.find_or_create_by_identifier(:name => e.name,:page_id=>e.page_id,:name=>e.name,:start_time=>e.start_time,
		:end_time=>e.end_time,:location=>e.location,:description=>e.description,:updated_time=>e.updated_time,
		:identifier=>e.identifier,:picture=>e.picture,:small_picture=>e.small_picture,:normal_picture=>e.normal_picture,
		:event_url=>e.event_url)
	oldevent.save
	e.event_updates.each do |u|
		puts "moving "+ e.name+ " event updates to old event updates No.:::::: "+ u.id.to_s if e.name
		oldevent.old_event_updates.create(:old_facebook_event_id=>oldevent.id,:attending=>u.attending,:maybe=>u.maybe,
			:invited=>u.invited)
	end
	e.destroy
end

t2 = Time.now
puts Time.now.strftime("%Y%m%d-%H%M%S") + " : " + __FILE__ + " finished  #{t2 - t1} secs"
puts "================"