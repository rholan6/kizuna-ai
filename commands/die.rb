module Aichan
    require_relative '../helpers/meme'
    require_relative '../helpers/foaas'

    #Make sure the needed directory exists
    if !Dir.exist? Memepool::DIE
        Dir.mkdir Memepool::DIE
    end

    #Kill the bot if run by the user specified in the wrangler file
    Aichan::BOT.command [:die, :kill, :stop], help_available: false  do |event|
        #If some random person tries to kill the bot, send them a pic telling them to go away
        #if event.user.id != wrangler
        unless IDS['wranglers'].include? event.user.id
            event.channel.send_file File.new(get_meme(Memepool::DIE)), caption: foaas('anyway', event.user.mention, Aichan::BOT.profile.mention)
            return
        end
    
        event.respond('またね！')
        Aichan::BOT.stop
        exit
    end
end
