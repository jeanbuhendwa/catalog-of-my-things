require_relative 'book'
require_relative 'label'
require_relative 'book_store'
require_relative 'label_store'
require 'json'

class BookUI
  attr_reader :book_store, :book_data, :label_data

  def initialize
    @book_store = BookStore.new
    @label_store = LabelStore.new
    @book_data = []
    @label_data = []
    load_book_data
    load_label_data
  end

  def list_books
    if @book_data.empty?
      puts 'There are no books yet.'
    else
      @book_data.each_with_index do |book, index|
        puts "#{index}) Id: #{book.id}, Publisher: #{book.publisher}, Cover State: #{book.cover_state}"
        puts "Publish Date: #{book.publish_date}"
        puts "Can be Archived: #{book.can_be_archived?}" # New line added
      end
    end
  end

  def list_labels
    if @label_data.empty?
      print 'There are no labels yet.'
    else
      @label_data.each_with_index do |label, index|
        puts "#{index}) Id: #{label.id}, Title: #{label.title}, Color: #{label.color}"
      end
    end
  end

  def add_book
    puts 'Enter Publisher Name:'
    publisher = gets.chomp
    puts 'Enter Cover State [good/bad]:'
    cover_state = gets.chomp
    puts 'Enter Publish Date:'
    publish_date = gets.chomp

    new_book = Book.new(publisher, cover_state, publish_date)
    @book_data << new_book
    save_book_data

    puts 'Book added successfully.'
    add_label
  end

  def add_label
    puts 'Enter Title:'
    title = gets.chomp
    puts 'Enter Color:'
    color = gets.chomp

    new_label = Label.new(title, color)
    @label_data << new_label
    save_label_data

    puts 'Label added successfully.'
  end

  def load_book_data
    if File.exist?(@book_store.book_file)
      file_contents = File.read(@book_store.book_file)
      @book_data = JSON.parse(file_contents).map do |book_data|
        Book.new(book_data['publisher'], book_data['cover_state'], book_data['publish_date'])
      end
    end
  rescue JSON::ParserError => e
    puts "Error parsing JSON file: #{e.message}"
  rescue Errno::ENOENT => e
    puts "File not found: #{e.message}"
  end

  def load_label_data
    if File.exist?(@label_store.label_file)
      file_contents = File.read(@label_store.label_file)
      @label_data = JSON.parse(file_contents).map do |label_data|
        Label.new(label_data['title'], label_data['color'])
      end
    end
  rescue JSON::ParserError => e
    puts "Error parsing JSON file: #{e.message}"
  rescue Errno::ENOENT => e
    puts "File not found: #{e.message}"
  end

  def save_book_data
    File.write(@book_store.book_file, JSON.generate(@book_data.map(&:to_json)))
  end

  def save_label_data
    File.write(@label_store.label_file, JSON.generate(@label_data.map(&:to_json)))
  end
end
