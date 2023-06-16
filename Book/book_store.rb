require 'json'

class BookStore
  attr_reader :book_file

  def initialize
    @book_file = File.expand_path('./book.json', __dir__)
  end

  def file_read(filename)
    file = File.read(filename)
    JSON.parse(file)
  end

  def file_write(filename, data)
    File.write(filename, JSON.generate(data))
  end

  def store_book_data(book_data)
    book_store = []
    book_store = file_read(@book_file) if File.exist?(@book_file)
    book_store << book_data
    file_write(@book_file, book_store)
  end
end
