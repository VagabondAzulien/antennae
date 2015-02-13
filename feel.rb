require 'rubygems'
require 'json'
require 'net/http'

def getStreams(user)
	#Establish few constants
	base_url = "https://api.twitch.tv/kraken/"
	client_id = "some really big number"
	head = {"Accept"=>"application/vnd.twitch.v2+json"} #, "Client-ID"=>client_id }

	#Compose the URL
	url = "#{base_url}/users/#{URI.encode(user)}/follows/channels"

	#Make the request
	req = http.get(URI.parse(url), initheader = head)
	data = req.body

	#convert to Ruby hash
	result = JSON.parse(data)

	#check for errors
	if result.has_key? 'error'
		raise "Shit broke"
	end
	
	#gimme the money Lebowski!
	return result
end

streamers = getStreams("vagabondazulien")

streamers["follows"].each {|key| 
	puts key["channel"]["name"]}
