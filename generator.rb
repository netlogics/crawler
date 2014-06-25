require_relative "lib/crawler/version"
require_relative "lib/config/initializers/boot"
require_relative "lib/crawler"
require 'nokogiri'
require 'logger'

class Generator
  class << self
    @@logger = Logger.new("lib/logs/sitemap_error.log")
    @@logger.level = Logger::ERROR

    def initialize
    end

    def generate_sitemap_index
    end

    def generate_sitemap(company)
      builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
        xml.urlset(:xmlns => 'http://www.sitemaps.org/schemas/sitemap/0.9') {
          domain = company.custom_domain
          unless domain.nil?
            create_dir(domain)
            if company.sitemaps.count > 0
              company.sitemaps.each do |sitemap|
                xml.url {
                  xml.loc sitemap.url
                }
              end
            end
          end
        }
      end

      write_file(company.custom_domain, builder)
    end

    def create_dir(sitemap_domain)
      path = File.join(get_path, "sitemaps", sitemap_domain)
      unless Dir.exists?(path)
        Dir.mkdir("#{path}", 0700)
      end
    end

    def get_path
      File.dirname(File.absolute_path(__FILE__))
    end


    def write_file(domain, sitemap)
      path = File.join(get_path, "sitemaps", domain)
      file = File.new("#{path}/sitemap.xml", "w+")
      file.write(sitemap.to_xml)
      file.close
    end
  end
end

#Generator.generate_sitemap(Crawler::Company.find(1))
Crawler::Company.find_each do |company|
  Generator.generate_sitemap(company) unless company.custom_domain.nil?
end
puts "Finished writing sitemap"



