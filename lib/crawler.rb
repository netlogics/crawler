require "mechanize"
require "uri"
require "logger"

module Crawler
  class Crawl
    @@logger = Logger.new("lib/logs/error.log")
    @@logger.level = Logger::ERROR

    attr_reader :page

    def initialize(uri='http://www.google.com')
      begin
        agent = Mechanize.new
        @page = agent.get(uri)
      rescue Mechanize::ResponseCodeError => ex
        @errors = "Mechanize::ResponseCodeError: #{ex.message}"
        @@logger.error "Mechanize::ResponseCodeError: #{ex.message}"
      end
    end

    def links
      if @errors.nil?
        links = @page.search(".//li/a[@href]").map {|node| node["href"]}
        links.uniq
      else
        []
      end
    end

  end
end

