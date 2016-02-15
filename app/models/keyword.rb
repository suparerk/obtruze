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
    time = rand(1..5)
    puts "-----> Search for #{self.title} will begin in #{time.minutes} seconds"
    SearchWorker.perform_in(time.minutes, self.id)
  end
end
