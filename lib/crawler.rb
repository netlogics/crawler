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
        agent.set_proxy 'localhost', 3000
        @page = agent.get(uri)
      rescue Mechanize::ResponseCodeError => ex
        @errors = "Mechanize::ResponseCodeError: #{ex.message}"
        @@logger.error "Mechanize::ResponseCodeError: #{ex.message}"
      rescue Mechanize::RedirectLimitReachedError => ex
        @errors = "Mechanize::RedirectLimitReachedError: #{ex.message}"
        @@logger.error "Mechanize::RedirectLimitReachedError: #{ex.message}"
      rescue Exception => ex
        # unknow exception is my own catch all not an actual 
        # Mechanize exception
        @errors = "Mechanize::UnknownException: #{ex.message}"
        @@logger.error "Mechanize::UnknownException: #{ex.message}"
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

