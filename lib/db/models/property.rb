module Crawler
  class Property < ActiveRecord::Base
    belongs_to :account, counter_cache: true
    has_one :company, through: :account
  end
end
