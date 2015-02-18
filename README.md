# Antennae
An attempt to fetch current live Twitch streams that I follow, and list them to standard output.

By default:
* The script finds all channels you follow, then checks each of those to determine if 
any of them are currently live. 

By extension:
* The script outputs results to STDOUT, which can be fed into a wrapper script to easily launch
[livestreamer](https://github.com/chrippa/livestreamer) with the requested script.

###README
####Usage
Just run the script, and it'll spit out the info.

But if you want to see the channels that _you_ follow, modify the "Twitch\_username" variable to your Twitch username

####To-Do
* [X] Complete script
* [ ] Leverage Typhoeus concurrent API calls and cut down wait time 
* [ ] Add wrapper for [livestreamer](https://github.com/chrippa/livestreamer)
* [ ] Add wrapper for use in [bar](https://github.com/LemonBoy/bar)

###CHANGELOG
####Current Version
* Date: 2015-02-18
* Changes:
	* + Script is functional

#####Older Versions

* Date: 2015-02-13
* Changes:
	* + Uploaded script
	* + Created/Populated README file
	* + Created/Populated LICENSE file
