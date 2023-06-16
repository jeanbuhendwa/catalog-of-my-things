require 'json'

class LabelStore
  attr_reader :label_file

  def initialize
    @label_file = File.expand_path('./label.json', __dir__)
  end

  def file_read(filename)
    file = File.read(filename)
    JSON.parse(file)
  end

  def file_write(filename, data)
    File.write(filename, JSON.generate(data))
  end

  def store_label_data(label_data)
    label_store = []
    label_store = file.read(@label_file) if File.exist?(@label_file)
    label_store << label_data
    file_write(@label_file, label_store)
  end
end
