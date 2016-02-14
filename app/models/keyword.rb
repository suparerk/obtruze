class Keyword < ActiveRecord::Base
  has_one :result, :dependent => :destroy
  accepts_nested_attributes_for :result
  after_create:save_result
  def self.import(file)
    keyword_array = Array.new
    CSV.foreach(file.path) do |row|
      keyword_array << row.compact.flatten unless row.compact.flatten.empty?
    end
    if keyword_array.present?
      keyword_array.flatten.each do |k|
        keyword = Keyword.where(title: k).first_or_initialize
        keyword.save
      end
      return true
    else
      false
    end
  end

  def save_result
    search_service = SearchService.new(self.title)
    search_service.search_results
    begin
      self.build_result(search_service.search_results)
      self.save
    rescue => e
      logger.warn "Unable to save keyword result : #{e}"
    end
  end

end
