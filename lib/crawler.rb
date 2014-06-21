require "mechanize"

module Crawler
  class Crawl
    attr_reader :page

    def initialize(uri='http://www.google.com')
      agent = Mechanize.new
      @page = agent.get(uri)
    end

    def links
      links = @page.search(".//li/a[@href]").map {|node| node["href"]}
      links.uniq
    end

  end
end

