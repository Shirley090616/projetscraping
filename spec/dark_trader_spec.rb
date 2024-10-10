require 'rspec'
require_relative '../lib/dark_trader'

describe 'scrap_crypto' do
  it 'should not return an empty array' do
    result = scrap_crypto
    puts "Résultat: #{result.inspect}"  # Affiche le résultat pour le débogage
    expect(result).to_not be_empty  # Vérifie que le tableau n'est pas vide
  end

  it 'should include BTC and ETH' do
    result = scrap_crypto
    puts "Résultat: #{result.inspect}"  # Affiche le résultat pour le débogage
    expect(result.any? { |crypto| crypto.keys.include?('BTC') }).to be true  # Vérifie la présence de "BTC"
    expect(result.any? { |crypto| crypto.keys.include?('ETH') }).to be true  # Vérifie la présence de "ETH"
  end
end