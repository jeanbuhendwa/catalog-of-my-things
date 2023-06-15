require_relative 'book'
require_relative 'label'
require_relative 'book_store'
require 'json'

class BookUI
  attr_reader :book_store, :book_data, :label

  def initialize
    @book_store = BookStore.new
    @book_data = []
    @label = []
    load_book_data
  end

  def list_books
    if @book_data.empty?
      puts 'There are no books yet.'
    else
      @book_data.each_with_index do |book, index|
        puts "#{index}) Id: #{book.id}, Publisher: #{book.publisher}, Publish Date: #{book.publish_date}"
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
  end

  def load_book_data
    begin
      if File.exist?(@book_store.book_file)
        file_contents = File.read(@book_store.book_file)
        @book_data = JSON.parse(file_contents).map { |book_data| Book.new(book_data['publisher'], book_data['cover_state'], book_data['publish_date']) }
      end
    rescue JSON::ParserError => e
      puts "Error parsing JSON file: #{e.message}"
    rescue Errno::ENOENT => e
      puts "File not found: #{e.message}"
    rescue => e
      puts "An error occurred: #{e.message}"
    end
  end

  def save_book_data
    File.open(@book_store.book_file, 'w') do |file|
      file.write(JSON.generate(@book_data.map(&:to_json)))
    end
  rescue => e
    puts "Error saving book data: #{e.message}"
  end
end

class Book
  attr_reader :publisher, :cover_state, :publish_date

  def initialize(publisher, cover_state, publish_date)
    @publisher = publisher
    @cover_state = cover_state
    @publish_date = publish_date
  end

  def to_json
    {
      'publisher' => @publisher,
      'cover_state' => @cover_state,
      'publish_date' => @publish_date
    }
  end
end
