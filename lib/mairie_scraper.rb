require 'nokogiri'
require 'httparty'

def get_townhall_email(townhall_url)
  response = HTTParty.get(townhall_url)
  parsed_page = Nokogiri::HTML(response.body)
  email = parsed_page.css('a[href^="mailto:"]').text.strip
  puts "Récupéré : #{email}"
  email
end

def get_townhall_urls
  base_url = 'http://annuaire-des-mairies.com/val-d-oise'
  response = HTTParty.get(base_url)
  parsed_page = Nokogiri::HTML(response.body)
  urls = parsed_page.css('a[href^="./"]').map { |link| " http://annuaire-des-mairies.com/#{link['href']}" }
  urls
end

def fetch_all_townhall_emails
  emails = []
  get_townhall_urls.each do |url|
    email = get_townhall_email(url)
    emails << { url.split('/').last => email }  #utilise le nom de la ville comme clé
  end
  emails
end

#teste la récupération des emails
puts fetch_all_townhall_emails