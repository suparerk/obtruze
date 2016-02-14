class ChangeColumnType < ActiveRecord::Migration
  def change
    change_table :results do |t|
      t.change :top_ads_url, "varchar[] USING (string_to_array(top_ads_url, ','))"
      t.change :right_ads_url, "varchar[] USING (string_to_array(right_ads_url, ','))"
      t.change :non_ads_url, "varchar[] USING (string_to_array(non_ads_url, ','))"
    end
  end
end
