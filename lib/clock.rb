require_relative "../config/environment"
require_relative "../config/boot"
require 'clockwork'

include Clockwork

handler do |job|
 puts "running the scheduled job #{job}."
end

# every(6.hours, 'Opta Text'){FourFourTwo.new.text}
# every(6.hours, 'Arscom Scraper'){`rake populater:arscom`}
# every(6.hours, 'Squawka Scraper'){`rake populater:squawka`}
every(15.seconds, 'Match Recorder'){BBC.new.is_it_time}