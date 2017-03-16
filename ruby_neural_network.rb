require 'rubygems'
require 'bundler/setup'
Bundler.require

# Tokenize text which includes doing the following:
# Lowercase the entire string
# Convert all - and _ to spaces
# Remove all non alphanumeric characters
# Split the string into an array of words using spaces as the delimiter
# Stem each individual word and return the resulting array
def format_text( text )
  formatted_text = text.downcase.gsub("-", " ").gsub("_", " ").gsub(/[^a-z0-9\s]/i, '').split(/\s+/)
  return formatted_text.map {|word| word.stem}
end

# Comput sigmoid nonlinearity
def sigmoid( x )
  return 1 / (1 + Math.exp(-x))
end

# Convert output of sigmoid function to its derivative
def sigmoid_output_to_derivative( output )
  return output*(1-output)
end

# Return bag of words array: 0 or 1 for each word in the bag that exists in the
# sentence
def bag_of_words( sentence_words, words )
  # Bag of Words
  bag = [0] * words.length
  for s in sentence_words
    if words.include? s
      bag[words.index(s)] = 1
    end
  end

  return bag
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

# create the training data
training = []
output = []

# training set, bag of words for each sentence
for doc in documents
  training.push(bag_of_words(doc[0], words))

  # output is a '0' for each tag and '1' for current tag
  output_row = [0] * classes.length
  output_row[classes.index(doc[1])] = 1
  output.push(output_row)
end



