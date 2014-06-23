module Crawler
  class Account < ActiveRecord::Base
    has_many :properties
    belongs_to :company
  end
end
