require 'nokogiri'
require 'httparty'
require 'json'
require 'dotenv'
require 'rspec'
require 'pry'
require_relative '../mairie_scraper'

RSpec.describe 'Mairie Scraper' do
  before do
    Dotenv.load  # Charge les variables d'environnement
  end

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
      # Simulation d'une page HTML avec des liens
      stub_request(:get, "http://annuaire-des-mairies.com/val-d-oise")
        .to_return(body: '<a href="./95/vaureal.html">Vaureal</a>', status: 200)

      urls = get_townhall_urls
      expect(urls).to be_an_instance_of(Array)
      expect(urls.first).to eq("http://annuaire-des-mairies.com/95/vaureal.html")
    end
  end

  describe '#fetch_all_townhall_emails' do
    it 'récupère un tableau de hashes avec les noms des mairies et leurs emails' do
      stub_request(:get, "http://annuaire-des-mairies.com/val-d-oise")
        .to_return(body: '<a href="./95/vaureal.html">Vaureal</a>', status: 200)

      stub_request(:get, "http://annuaire-des-mairies.com/95/vaureal.html")
        .to_return(body: '<a href="mailto:mairie@vaureal.fr">mairie@vaureal.fr</a>', status: 200)

      emails = fetch_all_townhall_emails
      expect(emails).to be_an_instance_of(Array)
      expect(emails.first).to eq({ "vaureal.html" => "mairie@vaureal.fr" })
    end
  end
end
