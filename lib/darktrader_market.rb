require 'nokogiri'  # analyse+lecture html
require 'open-uri'  # ouverture url+recup contenu

url = 'https://coinmarketcap.com/' #variable url

page = Nokogiri::HTML(URI.open(url))
puts page.class #pour verif si ok

cryptos_names = page.xpath('//a[@class="cmc-link"]') #prend nom crypto
cryptos_prices = page.xpath('//div[@class="price___3rj7O "]') #prend prix crypto

puts cryptos_names
puts cryptos_prices

cryptos = [] #tab vide
cryptos_names.each_with_index do |name, index|
crypto_hash = {}  #hash vide
crypto_hash[name.text] = cryptos_prices[index].text.gsub(/[^\d\.]/, '').to_f
cryptos << crypto_hash  #tab + hash
end

puts cryptos