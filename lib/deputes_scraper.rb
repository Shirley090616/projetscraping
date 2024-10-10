require 'nokogiri'
require 'httparty'

def fetch_deputy_emails
  url = 'https://www.assemblee-nationale.fr/dyn/votations'
  response = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(response.body)

  deputies = []
  parsed_page.css('.deputes').each do |deputy_element|
    first_name = deputy_element.css('.first-name').text.strip
    last_name = deputy_element.css('.last-name').text.strip
    email = deputy_element.css('.email').text.strip
    deputies << { "first_name" => first_name, "last_name" => last_name, "email" => email }
    puts "Récupéré : #{first_name} #{last_name} - Email : #{email}"
  end

  deputies
end

# Teste la récup des e-mails des députés
puts fetch_deputy_emails