require 'rubygems'
require 'bundler/setup'
Bundler.require

def format_text( text )
  formatted_text = text.downcase.gsub("-", " ").gsub("_", " ").gsub(/[^a-z0-9\s]/i, '').split(/\s+/)
  return formatted_text.map {|word| word.stem}
end

# Use neural networks to classify articles
training_data = [
  {"class": "greeting", "text": "how are you?"},
  {"class": "greeting", "text": "how is your day"},
  {"class": "greeting", "text": "good day"},
  {"class": "greeting", "text": "how is it going today?"},
  {"class": "goodbye", "text": "have a nice day"},
  {"class": "goodbye", "text": "see you later"},
  {"class": "goodbye", "text": "talk to you soon"},
  {"class": "sandwich", "text": "make me a sandwich"},
  {"class": "sandwich", "text": "can you make a sandwich?"},
  {"class": "sandwich", "text": "having a sandwich today?"},
  {"class": "sandwich", "text": "what's for lunch?"},
]

words = []
classes = []
documents = []
ignore_words = ["?"]

# loop through each sentence in the training data
for pattern in training_data
  # tokenize each word in the sentence
  w = format_text(pattern[:text])

  # add to list of words
  words.concat(w)

  # add to documents in corpus
  documents.push([w, pattern[:class]])

  # add to list of classes
  if !(classes.include? pattern[:class])
    classes.push(pattern[:class])
  end
end

# Deduplicate words and classes list
words = words.uniq
classes = classes.uniq

# Display words, classes, documents
# puts documents.length.to_s + " documents: " + documents.to_s
# puts classes.length.to_s + " classes: " + classes.to_s
# puts words.length.to_s + " unique stemmed words: " + words.to_s

# create the training data
training = []
output = []

# training set, bag of words for each sentence
for doc in documents
  # initialize bag of words
  bag = []

  # list of tokenized words for the pattern
  pattern_words = doc[0]

  # create our bag of words array
  for w in words
    if pattern_words.include? w
      bag.push(1)
    else
      bag.push(0)
    end
  end

  training.push(bag)

  # output is a '0' for each tag and '1' for current tag
  output_row = [0] * classes.length
  output_row[classes.index(doc[1])] = 1
  output.push(output_row)
end

# Display training arrays
# puts "doc"
# puts documents[0][0].to_s
# puts "training"
# puts training[0].to_s
# puts "output"
# puts output[0].to_s





