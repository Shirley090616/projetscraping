require 'nokogiri'
require 'httparty'
require 'dotenv'
require 'pry'

# Charger les variables d'environnement depuis un fichier .env (si nécessaire)
Dotenv.load

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
  urls = parsed_page.css('a[href^="./"]').map { |link| "http://annuaire-des-mairies.com/#{link['href'][1..]}" }
  urls
end

def fetch_all_townhall_emails
  emails = []
  get_townhall_urls.each do |url|
    email = get_townhall_email(url)
    townhall_name = url.split('/').last
    emails << { townhall_name => email }
  end
  emails
end
puts fetch_all_townhall_emails

# Test manuel (décommentez pour tester)
# puts fetch_all_townhall_emails

# Utilisation de pry pour déboguer
# binding.pry
