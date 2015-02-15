#feel -- get the info
#bill_niblock@yahoo.com

require 'rubygems'
require 'json'
require 'net/http'

#Establish a few constants
Twitch_baseurl = "https://api.twitch.tv/kraken"
Twitch_clientid = "dejgwfi5bg3m1js5y6yjedp985tc5rm"

########################################################
# CHANGE THIS TO MODIFY WHO WE'RE GETTING THE INFO FOR #
########################################################
Twitch_username = "vagabondazulien"


def getStreams(user)
	#Establish few constants
	head = {"Accept"=>"application/vnd.twitch.v2+json", "Client-ID"=>Twitch_clientid }

	#Compose the URL
	url = "#{Twitch_baseurl}/users/#{URI.encode(user)}/follows/channels"

	#Make the request
	#req = Net::HTTP.get_response(URI.parse(url))
	http = Net::HTTP.new(url.host, url.port)
	req = http.get(url, initheader = head)
	data = req.body

	#Convert to Ruby hash
	result = JSON.parse(data)

	#Check for errors
	if result.has_key? 'error'
		raise "Nope... something didn't work..."
	end
	
	#Gimme the money Lebowski!
	return result
end

def getLive(streams)

end

streamers = getStreams(Twitch_username)

streamers["follows"].each {|key| 
	puts key["channel"]["name"]}
