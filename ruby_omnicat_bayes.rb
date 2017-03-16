require 'rubygems'
require 'bundler/setup'
Bundler.require

bayes = OmniCat::Classifiers::Bayes.new
bayes.add_category('greeting')
bayes.add_category('goodbye')
bayes.add_category('sandwich')

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
  bayes.train(label, content.to_s)
end

puts "make me a sandwich"
puts bayes.classify("make me a sandwich").to_hash
puts "how are you today?"
puts bayes.classify("how are you today?").to_hash
puts "talk to you tomorrow"
puts bayes.classify("talk to you tomorrow").to_hash
puts "who are you?"
puts bayes.classify("who are you?").to_hash
puts "make me some lunch"
puts bayes.classify("make me some lunch").to_hash
puts "how was your lunch today?"
puts bayes.classify("how was your lunch today?").to_hash
puts "how are you doing today?"
puts bayes.classify("how are you doing today?").to_hash