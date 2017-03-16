# Test to classify text using Ruby

require 'rubygems'
require 'bundler/setup'
Bundler.require

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

categories = ["greeting", "goodbye", "sandwich"]

classifier = ClassifierReborn::Bayes.new stopwords: [], auto_categorize: true

training_set.each do |content, label|
  classifier.train(label, content.to_s)
end

puts "make me a sandwich"
puts classifier.classify "make me a sandwich"
puts "how are you today?"
puts classifier.classify "how are you today?"
puts "talk to you tomorrow"
puts classifier.classify "talk to you tomorrow"
puts "who are you?"
puts classifier.classify "who are you?"
puts "make me some lunch"
puts classifier.classify "make me some lunch"
puts "how was your lunch today?"
puts classifier.classify "how was your lunch today?"
puts "how are you doing today?"
puts classifier.classify "how are you doing today?"