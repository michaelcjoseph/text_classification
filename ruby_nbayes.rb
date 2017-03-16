require 'rubygems'
require 'bundler/setup'
Bundler.require

def format_text( text )
  lowercase_text = text.downcase
  if lowercase_text.include? "read more"
    lowercase_text = lowercase_text.gsub("read more", "")
  end

  formatted_text = lowercase_text.downcase.gsub("-", " ").gsub("_", " ").gsub(/[^a-z0-9\s]/i, '').split(/\s+/)
  return formatted_text.map {|word| word.stem}
end

# Test nbayes out on a basic set of data. On the basic set of data, it works 
# better than both classifier and omnicat-bayes

nbayes_basic_test = NBayes::Base.new

training_set = {
  "how are you": "greeting",
  "how is your day": "greeting",
  "good day": "greeting",
  "how is it going today": "greeting",
  "have a nice day": "goodbye",
  "see you later": "goodbye",
  "talk to you soon": "goodbye",
  "make me a sandwich": "sandwich",
  "can you make me a sandwich?": "sandwich",
  "having a sandwich?": "sandwich",
  "what\'s for lunch?": "sandwich"
}

training_set.each do |content, label|
  nbayes_basic_test.train(format_text(content.to_s), label)
end

puts "make me a sandwich"
puts nbayes_basic_test.classify(format_text("make me a sandwich")).max_class
puts "how are you today?"
puts nbayes_basic_test.classify(format_text("how are you today?")).max_class
puts "talk to you tomorrow"
puts nbayes_basic_test.classify(format_text("talk to you tomorrow")).max_class
puts "who are you?"
puts nbayes_basic_test.classify(format_text("who are you?")).max_class
puts "make me some lunch"
puts nbayes_basic_test.classify(format_text("make me some lunch")).max_class
puts "how was your lunch today?"
puts nbayes_basic_test.classify(format_text("how was your lunch today?")).max_class
puts "how are you doing today?"
puts nbayes_basic_test.classify(format_text("how are you doing today?")).max_class

# Now test nbayes out on data from current articles using just
# the title and description of the articles. All text should also be formatted
# so that it is the same (remove punctuation etc)

nbayes_articles = NBayes::Base.new

articles_training_set = {
  "Can Trump unite Republicans over healthcare and a new budget? The president is set to reveal his fiscal budget for 2018 on Thursday, potentially deepening existing divides between GOP lawmakers in the Republican-controlled Congress.": "Politics",
  "Are this Iowa congressman's views on immigration racist? Rep. Steve King has come under fire for tweeting that Americans 'can't restore our civilization with somebody else's babies.'": "Politics",
  "Can White House Bowling Heal GOP Divisions And Spare The Health Care Bill? President Trump has been in \"sell mode\" on the health care bill, and he has invited conservative GOP members of Congress over to the White House bowling alley this week.": "Politics",
  "Wowing and washable: Google’s smart jacket wears and works well at first glance \"Blinking on your jacket is uncool\"—luckily this looks the part while having its brains.": "Tech",
  "You'll never shop alone again In virtual and physical stores, retailers are tracking customers' buying habits, biometric information, and personal preferences. And few consumers even know they are being watched.": "Tech",
  "How America’s Electric-Car Market Could Get Stuck in the Slow Lane If tax breaks and other incentives continue to disappear, it will be hard work convincing consumers to swap gasoline for electrons.": "Tech"
}

articles_training_set.each do |content, label|
  nbayes_articles.train(format_text(content.to_s), label)
end

test_article = "Intel’s $15 Billion Mobileye Buyout Puts It in the Autonomous Car Driver’s Seat The acquisition bags the chip maker a pivotal contender in the race to build robotic cars."
puts "Test Article"
result = nbayes_articles.classify(format_text(test_article))
puts result.max_class
puts result["Politics"]
puts result["Tech"]