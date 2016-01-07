# coding: utf-8
require_relative 'book_search.rb'

def init
  puts "Enter the text to be searched for: "
  text = gets
  res = GoogleBookSearch::FullText::search("#{text}",
                                           # Don't return ALL fields,
                                           # only important ones
                                           {projection: 'lite'})
  puts
  puts "Text found in the following titles (and more): "
  puts
  # Wait 20 seconds for the response before cancelling
  # If successfull, map over the value and print each title
  puts res.value(20)['items'].map {|item| item['volumeInfo']['title']}
end

init
