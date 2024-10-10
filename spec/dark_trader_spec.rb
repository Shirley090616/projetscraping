require_relative '../lib/dark_trader.rb'

describe 'scrap_crypto' do
  it 'should not return an empty array' do
    expect(scrap_crypto).to_not be_empty  # Vérifie que le tableau n'est pas vide
  end

  it 'should include BTC and ETH' do
    result = scrap_crypto
    expect(result.any? { |crypto| crypto.keys.include?('BTC') }).to be true  # Vérifie la présence de "BTC"
    expect(result.any? { |crypto| crypto.keys.include?('ETH') }).to be true  # Vérifie la présence de "ETH"
  end
end