require_relative "lib/crawler/version"
require_relative "lib/config/initializers/boot"
require_relative "lib/crawler"


companies = Crawler::Company.find(8,168)
companies.each do |company|
  domain = company.custom_domain
  page = Crawler::Crawl.new("http://www.#{domain}/")
  urls = []
  page.links.each do |link|
    # Remove / from any link that begins with a /
    link = link[0] == '/' ? link[1..link.length] : link
    # Insert http:// to beginning of string unless they already begin with http://
    link.insert(0, "http://www.#{domain}/") unless link.include?("http://") || link.include?("https://")
    # If the link contains the company custom domain or property slug it is valid. Otherwise
    # it's an outside link. Remove outside links from result set
    #if link.include?("arroyo-vista-apartments")
    urls << link if link.include?(domain)
    #end
  end
  urls.each {|url| puts url}
end

