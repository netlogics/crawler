module Crawler
  class Sitemap < ActiveRecord::Base
    belongs_to :company

    before_validation :clean
    validates_uniqueness_of :url, scope: :company_id, message: "Url already exists for this company"

    def clean
      # Removes trailing /'s and/or #'s
      url.gsub!(/[\/\#]*$/, "")
    end
  end
end
