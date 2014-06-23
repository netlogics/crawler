module Crawler
  class Company < ActiveRecord::Base
    has_many :properties, through: :accounts
    has_one :account, class_name: 'Account', foreign_key: :company_id
    has_many :properties, through: :account, dependent: :destroy
  end
end
