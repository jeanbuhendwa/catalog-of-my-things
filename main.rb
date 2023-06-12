require_relative 'item'

item1 = Item.new('2020-06-12')
item1.genre = 'Fiction'
item1.author = 'John Doe'
item1.source = 'Book'
item1.label = 'Bestseller'

puts "Item 1:"
puts "ID: #{item1.instance_variable_get(:@id)}"
puts "Publish Date: #{item1.publish_date}"
puts "Archived: #{item1.archived}"
puts "Genre: #{item1.genre}"
puts "Author: #{item1.author}"
