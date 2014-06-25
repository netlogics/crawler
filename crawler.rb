require_relative "lib/crawler/version"
require_relative "lib/config/initializers/boot"
require_relative "lib/crawler"
require "uri"
require "logger"

def crawl(domain, subdomain = "")
  page = Crawler::Crawl.new("http://www.#{domain}/#{subdomain}")
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
  urls
end

def has_properties(company)
  company.properties.count > 0
end

def clear_sitemaps
  Crawler::Sitemap.delete_all
end

logger = Logger.new("lib/logs/info.log")
logger.level = Logger::INFO

urls = []
clear_sitemaps
Crawler::Company.find_each do |company|
  puts company.custom_domain
  logger.info "Company - #{company.name}:#{company.id}"
  unless company.custom_domain.nil?
    urls = crawl(company.custom_domain)
    if has_properties(company)
      company.properties.find_each do |property|
        urls += crawl(company.custom_domain, property.subdomain)
      end
    end

    logger.info "Adding #{urls.count} URL's for #{company.name}"
    urls.each do |link|
      Crawler::Sitemap.create(url: link, company_id: company.id)
    end

  else
    logger.info "No custom domain for #{company.name}:#{company.id}"
  end
end

puts "\n\nCRAWLING COMPLETE"

