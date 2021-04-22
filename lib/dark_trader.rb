require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))   

crypto_name = page.xpath('//tr/td[2]//a[contains(@href, "currencies")]')
crypto_price = page.xpath('//tr/td[5]//a[contains(@href, "markets")]')

#crypto_name(1)
# =
#<a href="/currencies/origintrail/" title="OriginTrail" class="cmc-link">OriginTrail</a>

#t / tableau

#// tr : toutes les lignes

#td2 : 2ème colonne

crypto_name_text = []
crypto_price_text = []

crypto_price.each do |crypto_price_element|
  crypto_price_text << crypto_price_element.text
end

crypto_name.each do |crypto_name|
  crypto_name_text << crypto_name.text 
end

names_and_prices = Hash[crypto_name_text.zip(crypto_price_text)]

puts names_and_prices