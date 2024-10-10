require 'nokogiri' #utilise pour le parsing HTML et extraction données
require 'httparty' #utilise pour faire les requetes http + obtenir les rep.

def fetch_crypto_prices
    url = 'https://coinmarketcap.com/'
    response = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(response.body)
  
    crypto_data = []
    parsed_page.css('.currency-name-container').each do |name_element| # selectionne les elements html + each itere s/chaque element selectionne
      name = name_element.text.strip
      price = name_element.parent.css('.price').text.strip
      crypto_data << { name => price }
      puts "Récupéré : #{name} - Prix : #{price}"  # Affiche les infor dans le terminal
    end
  
    crypto_data
  end
  
  # Appele la méthode pour tester
  puts fetch_crypto_prices