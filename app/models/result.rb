class Result < ActiveRecord::Base
  belongs_to :keyword, :foreign_key => 'keyword_id'
end
