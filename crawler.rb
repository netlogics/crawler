require_relative "lib/crawler/version"
require_relative "lib/config/initializers/boot"
require_relative "lib/crawler"

page = Crawler::Crawl.new("http://www.isyourhome.com")
=begin
subset = page.links.slice(3..page.links.length)
if subset.include?(page.links[2])
  puts "Duplicate found"
else
  puts "No Duplicates"
end
=end

page.links.each {|link| puts link["href"]}

