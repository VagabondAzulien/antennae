#wrapper for Livestreamer


require './feel.rb'

def main()
     #Calls the Feel program to fetch currently live streams
     #Feel returns a hash of live channels with several pieces
     #    of information. More details in feel.rb
     channels = feel::main.new()
     channelURL = {}
     channelCount = 1

     #Format output, present options
     channels.each { |live|
        puts "[#{channelCount}] #{live["Name"]}: #{live["Status"]}"
        printf "\t#{live["Game"]} | #{live["Viewers"]} | #{live["Live"]}\n\n"
        channelURL[channelCount]= live["Url"]
        channelCount += 1
     }

     #Gets the input, based on output above
     print "Which one to watch? [1-#{channelCount}, or q to quit]:" 
     tmp = gets.chomp
     
     #Verifies option is one of the above, otherwise
     #    throws basic error message and prompts again.
     #    The user can always use "q" to exit.
     
     #Calls livestreamer to start the show
     # livestreamer #{channelURL["tmp"]} source
end
