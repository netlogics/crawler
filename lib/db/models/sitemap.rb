module Crawler
  class Sitemap < ActiveRecord::Base
    before_validation :remove_trailing_slash
    validates_uniqueness_of :url, scope: :company_id, message: "Invalid url entry. Url already exists for the company"

    def remove_trailing_slash?
      url.gsub!(/\/$/, "") if url.end_with? "/"
    end
  end
end
