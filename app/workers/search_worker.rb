class SearchWorker
  include Sidekiq::Worker
  sidekiq_options retry: 5

  def perform(keyword_id)
    keyword = Keyword.find keyword_id
    puts "-----> Start search for #{keyword.title}"
    search_service = SearchService.new(keyword.title)
    puts "-----> search results for #{keyword.title} have been saved!"
    begin
      keyword.build_result(search_service.search_results)
      keyword.save
    rescue => e
      logger.warn "-----> Unable to save keyword result : #{e}"
    end
  end
end
