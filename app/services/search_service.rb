class SearchService
  require 'nokogiri'
  require 'open-uri'

  def initialize(keyword)
    @keyword = keyword
    @page = open "https://www.google.com/search?q=#{@keyword}&pws=0&gl=us&gws_rd=cr#q=flower+delivery&pws=0&gl=us&start=0"
    @html = Nokogiri::HTML @page
  end

  def get_result_page
    @html
  end

  def get_top_ads_results
    top_ads_results = @html.xpath("//div[contains(@id,'center_col')]//div[contains(@class,'ads-visurl')]//cite").collect {|node| node.text.strip}
  end

  def get_right_ads_results
    right_ads_results = @html.xpath("//td[@id='rhs_block']//cite").collect {|node| node.text.strip}
  end

  def get_all_results
    results = @html.xpath("//div[contains(@id,'resultStats')]").collect {|node| node.text.strip}
  end

  def get_non_ads_results
    non_ads_results = @html.xpath("//div[contains(@id,'res')]//div[contains(@class,'kv')]//cite").collect {|node| node.text.strip}
  end
end
