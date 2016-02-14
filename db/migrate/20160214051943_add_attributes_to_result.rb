class AddAttributesToResult < ActiveRecord::Migration
  def change
    add_column :results, :no_top_ads, :integer
    add_column :results, :no_right_ads, :integer
    add_column :results, :total_ads, :integer
    add_column :results, :top_ads_url, :text
    add_column :results, :right_ads_url, :text
    add_column :results, :no_non_ads, :integer
    add_column :results, :non_ads_url, :text
    add_column :results, :total_links, :integer
    add_column :results, :total_search_results, :integer
    add_column :results, :page_cache, :text
  end
end
