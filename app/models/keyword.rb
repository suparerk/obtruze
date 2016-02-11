class Keyword < ActiveRecord::Base
  after_create :save_result
  def self.import(file)
    keyword_array = Array.new
    CSV.foreach(file.path) do |row|
      keyword_array << row.compact.flatten unless row.compact.flatten.empty?
    end
    keyword_array.flatten
  end

  def save_result
    search_service = SearchService.new(self.title)
  end

end
