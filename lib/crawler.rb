require "mechanize"
require "mechanize"

module Crawler
  class Crawl
    attr_reader :page

    def initialize(uri='http://www.google.com')
      agent = Mechanize.new
      @page = agent.get(uri)
    end

    def links
      #@page.search(".//li/a[@href]").each {|node| puts node["href"]}
      #@page.search(".//li/a[@href]")
      #sanitize(@page.search(".//li/a[@href]")).map {|node| node["href"]}
      sanitize(@page.search(".//li/a[@href]"))
    end

    private

    def sanitize(nodeset)
=begin
      i = 0
      length = nodeset.length

      until i == length do
        subset = nodeset.slice((i + 1)..length)
        index = subset.index(nodeset[i])
        puts "Include?: #{subset.include?(nodeset[i])}"
        unless index.nil?
          nodeset.delete(nodeset[i])
        end
        i += 1
      end
=end
      i = 2
      subset = nodeset.slice((i + 1)..nodeset.length)
      subset
    end

  end
end

