#feel -- get the info
#bill_niblock@yahoo.com

require 'rubygems'
require 'json'
require 'net/http'
require 'typhoeus'

#Establish a few constants
Twitch_url = "https://api.twitch.tv/kraken"
Twitch_clientid = "dejgwfi5bg3m1js5y6yjedp985tc5rm"
Twitch_headers = {"Accept"=>"application/vnd.twitch.v2+json", "Client-ID"=>"#{Twitch_clientid}"} 

########################################################
# CHANGE THIS TO MODIFY WHO WE'RE GETTING THE INFO FOR #
########################################################
Twitch_username = "vagabondazulien"

def main()
	#Get Streamers
	streamers = getStreams(Twitch_username, 0, streams=[])

	streamers.each { |channel|
		tmp = getLive(channel)
		if not tmp.nil?
			puts "#{tmp["channel"]["display_name"]} streaming #{tmp["game"]}"
		end
	}
end

def getStreams(user, offset, streams)
	#Using Typhoeus, construct a GET request with appropriate headers
	#to appropriate API, and then get the body of the returned values
	data = Typhoeus::Request.new(
		"#{Twitch_url}/users/#{URI.encode(user)}/follows/channels",
		headers: Twitch_headers, 
		params: {"offset"=>"#{offset}", "limit"=>"100"}
	).run.body

	#Convert to Ruby hash
	result = JSON.parse(data)

	#Check for errors
	#(This should probably be expanded...)
	if result.has_key? 'error'
		raise "Nope... something didn't work..."
	end

	#Filter out the streamers' channel names, add it to the streams array
	result["follows"].each { |key|
		streams.push("#{key["channel"]["name"]}")}

	#Tail recursion is super sexy
	#	if the most recent number of results fetched for followers is 0, then end
	#	otherwise, fetch more!
	if result["follows"].length == 0
		#Gimme the money Lebowski!
		return streams
	else
		getStreams(user, (offset += 100), streams)
	end
end

def getLive(stream)
	#Using Typhoeus similarly to getStreams implementation
	data = Typhoeus::Request.new(
		"#{Twitch_url}/streams/#{stream}",
		headers: Twitch_headers,
	).run.body

	#Convert to Ruby hash
	result = JSON.parse(data)

	#Return information only for live channels
	if result["stream"].nil?
		return
	else
		return result["stream"]
	end
end

main	#START ZE MACHINE!
