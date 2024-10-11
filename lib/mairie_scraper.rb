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
  urls = parsed_page.css('a[href^="./"]').map { |link| "http://annuaire-des-mairies.com/#{link['href'][1..]}" } # On enlève le premier caractère '.'
  urls
end

def fetch_all_townhall_emails
  emails = [] # Initialisation du tableau pour stocker les hashes
  get_townhall_urls.each do |url|
    email = get_townhall_email(url) # Récupérer l'email
    townhall_name = url.split('/').last # Récupérer le nom de la mairie à partir de l'URL
    emails << { townhall_name => email }  # Ajouter un hash au tableau
  end
  emails
end

# Test récup emails
puts fetch_all_townhall_emails