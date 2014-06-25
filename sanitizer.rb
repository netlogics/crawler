require_relative "lib/crawler/version"
require_relative "lib/config/initializers/boot"
require_relative "lib/crawler"

Crawler::Company.find_each do |company|
  #uniq_sitemaps = Crawler::Sitemap.find_by_sql("select distinct on (s.url) * from sitemaps as s where company_id = 1 order by s.url")
  uniq_sitemaps = Crawler::Sitemap.find_by_sql("select distinct on (s.url) * from sitemaps as s where company_id = #{company.id} order by s.url")
  company.sitemaps.delete_all
  uniq_sitemaps.each {|sitemap| Crawler::Sitemap.create(url: sitemap.url, company_id: sitemap.company_id)}
end

puts "Finished"

