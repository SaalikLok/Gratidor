# open config
configData = File.read("config.txt").split

$firstTime = configData[0]
$name = configData[1]

# Logig deciding whether someone is here for the first time.
def boot
    system "clear"

    if $firstTime == "true"
        return firstStart
    else
        return mainMenu("Hey #{$name}, it's Gratidor!")
    end
end


# The Main Menu
def mainMenu(entryMessage)
    system "clear"
    puts entryMessage
    puts
    puts "What would you like to do? (Enter the number)"
    puts "1 - Add a Gratitude"
    puts "2 - Random Gratitude"
    puts "3 - Exit"
    puts
    print "Your Response: "
    response = gets.chomp

    if response == "1"
        return addToJournal
    elsif response == "2"
        return readFromJournal
    elsif response == "3"
        exit
    elsif response.downcase == "reset"
        return reset
    else
        return mainMenu("Hmm, I didn't get that.")
    end
end

# TODO: Add a fun Gratidor quiz at the beginning of this firstStart

# Opening Gratidor for the first time.
def firstStart
    puts "This is your first time here, eh? Well, nice to meet you!"
    puts "You must be wondering what this whole thing is. Let's start there. I'm Gratidor, a gratitude journal and trusty sidekick."
    puts
    puts "Let's start with the basics. What's your name?"
    $name = gets.chomp

    File.write("config.txt", "false\n#{$name}")

    puts
    puts "So great to meet you."
    puts "Let's start your journal #{$name}."
    puts "On the next page, you'll get to enter whatever you're grateful for. Press anything to continue."
    gets
    
    return addToJournal
end


# Adding a New Entry
def addToJournal
    system "clear"
    puts "What are you grateful for today?"
    grat = gets.chomp

    puts "Awesome. Press any key to confirm your gratitude, or 'x' to discard it."
    response = gets

    if response != "x" || response != "X"
        File.write("gratitudes.txt", "#{grat} ~ #{Time.now.strftime("%d/%m/%Y %H:%M")}\n", mode: "a")
        return mainMenu("Gratitude Recorded!")
    end

    return mainMenu("Message Discarded.")
end


# Reading from Journal
def readFromJournal
    system "clear"
    journalData = File.read("gratitudes.txt").split("\n")
    entry = rand(journalData.length - 1)
    puts journalData[entry]
    puts
    puts
    print "Press any key when you're done reading."
    gets

    return mainMenu("It's awesome reflecting on past gratitude, isn't it?")
end


# Resetting all data
def reset 
    system "clear"
    puts "Are you sure you'd like to reset all your data on Gratidor? (Type 'Y' to confirm)"
    puts "This will end Gratidor for now."
    confirm = gets.chomp

    if confirm == 'y' || confirm == 'Y'
        File.write("config.txt", "true\nthere")
        File.write("gratitudes.txt", "")
    end
end

boot