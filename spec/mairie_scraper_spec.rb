require 'nokogiri'
require 'httparty'
require 'webmock/rspec'
require_relative '../townhall'  # Remplacez 'townhall' par le nom de votre fichier

RSpec.describe 'Townhall Scraper' do
  describe '#get_townhall_email' do
    it 'récupère l\'email de la mairie à partir de son URL' do
      # Simulation d'une page HTML avec un email
      stub_request(:get, "http://annuaire-des-mairies.com/95/vaureal.html")
        .to_return(body: '<a href="mailto:mairie@vaureal.fr">mairie@vaureal.fr</a>', status: 200)

      email = get_townhall_email('http://annuaire-des-mairies.com/95/vaureal.html')
      expect(email).to eq('mairie@vaureal.fr')
    end
  end

  describe '#get_townhall_urls' do
    it 'récupère une liste d\'URLs des mairies du Val-d\'Oise' do
      # Simulation d'une page HTML avec des liens vers des mairies
      stub_request(:get, "http://annuaire-des-mairies.com/val-d-oise")
        .to_return(body: '<a href="./95/vaureal.html">Vaureal</a>', status: 200)

      urls = get_townhall_urls
      expect(urls).to be_an_instance_of(Array)
      expect(urls.first).to eq("http://annuaire-des-mairies.com/95/vaureal.html")
    end
  end

  describe '#fetch_all_townhall_emails' do
    it 'récupère un tableau de hashes avec les noms des mairies et leurs emails' do
      # Simulation de la page contenant les URLs des mairies
      stub_request(:get, "http://annuaire-des-mairies.com/val-d-oise")
        .to_return(body: '<a href="./95/vaureal.html">Vaureal</a>', status: 200)

      # Simulation de la page de la mairie avec un email
      stub_request(:get, "http://annuaire-des-mairies.com/95/vaureal.html")
        .to_return(body: '<a href="mailto:mairie@vaureal.fr">mairie@vaureal.fr</a>', status: 200)

      emails = fetch_all_townhall_emails
      expect(emails).to be_an_instance_of(Array)
      expect(emails.first).to eq({ "vaureal.html" => "mairie@vaureal.fr" })
    end
  end
end
