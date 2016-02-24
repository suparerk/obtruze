class SearchService
  require 'open-uri'

  def initialize(keyword)
    @keyword = keyword
    @page = open "https://www.google.com/search?q=#{keyword}&pws=0&gl=us&gws_rd=cr"
    @html = Nokogiri::HTML @page
  end


  def search_results
    top_ads_results = get_top_ads_results
    right_ads_results = get_right_ads_results
    non_ads_results = get_non_ads_results
    @hash_result = {:no_top_ads => top_ads_results.count,
                  :top_ads_url => top_ads_results,
                  :no_right_ads => right_ads_results.count,
                  :right_ads_url => right_ads_results,
                  :total_ads => top_ads_results.count + right_ads_results.count,
                  :no_non_ads => non_ads_results.count,
                  :non_ads_url => non_ads_results,
                  :total_links => top_ads_results.count + right_ads_results.count + right_ads_results.count + non_ads_results.count,
                  :total_search_results => get_all_results,
                  :page_cache => get_result_page
    }
  end

  private

  def get_result_page
    # @html.to_s.force_encoding('Windows-1252').encode('UTF-8')
    # @html.to_s.encode("iso-8859-1").force_encoding("utf-8")
    # @html.text.gsub('®','')
    @html.to_s

  end

  def get_top_ads_results
    top_ads_results = @html.xpath("//div[contains(@id,'center_col')]//div[contains(@class,'ads-visurl')]//cite").collect {|node| node.text.strip}
  end

  def get_right_ads_results
    right_ads_results = @html.xpath("//td[@id='rhs_block']//cite").collect {|node| node.text.strip}
  end

  def get_non_ads_results
    non_ads_results = @html.xpath("//div[contains(@id,'res')]//div[contains(@class,'kv')]//cite").collect {|node| node.text.strip}
  end

  def get_all_results
    results = @html.xpath("//div[contains(@id,'resultStats')]").collect {|node| node.text.strip}
  end
end
