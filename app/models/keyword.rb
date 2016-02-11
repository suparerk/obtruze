class Keyword < ActiveRecord::Base
  require 'csv'

  def self.import(file)
    keyword_array = Array.new
    CSV.foreach(file.path) do |row|
      keyword_array << row.compact.flatten unless row.compact.flatten.empty?
    end
    keyword_array.flatten
  end
end
