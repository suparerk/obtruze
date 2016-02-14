class ChangeDataTypeForTotalSearchResults < ActiveRecord::Migration
  def change
    change_table :results do |t|
      t.change :total_search_results, :string
    end
  end
end
