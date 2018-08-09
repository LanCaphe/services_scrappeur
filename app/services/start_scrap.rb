require 'nokogiri'
require 'open-uri'

class StartScrap

  attr_accessor :name
  attr_accessor :value

  def initialize(name)
    @url = Nokogiri::HTML(open('https://coinmarketcap.com/all/views/all/'))
    @name = name
    @value = value

  end

  def perform
    page = @url

    name = []

    page.css('a.currency-name-container.link-secondary').each do |each_name|
      name << each_name.text
    end

    value = []

    page.css('a.price').each do |each_value|
      value << each_value.text
    end

    @crypto_hash = Hash[name.zip(value)]

    puts "#{@crypto_hash}"

    save

  end

  def save
    a = Crypto.all.ids
    if a.length == 1
      Crypto.last.destroy
    end
    Crypto.create(name: "#{@name}", value: "#{@crypto_hash.values_at("#{@name}")}")
  end
end