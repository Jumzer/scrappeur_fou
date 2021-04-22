require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(URI.open("http://www.annuaire-des-mairies.com/val-d-oise.html"))

cities_bad_url = page.xpath('//tr//td//a[contains(@href,"95")]')
# <a class="lientxt" href="./95/ambleville.html">AMBLEVILLE</a>

cities_url_good = []
cities_name = []


cities_bad_url.each do |cities_bad_url_element|
  cities_not_so_bad_element = cities_bad_url_element['href']
  # ./95/ambleville.html
  cities_url_good << cities_not_so_bad_element[1..]
  # /95/ambleville.html
  cities_name << cities_bad_url_element.text
  #nouvelle array avec nom des villes
end

#on veut
#https://www.annuaire-des-mairies.com/95/ambleville.html

cities_mail = []

cities_url_good.each do |cities_url_good_element|
  city_page = Nokogiri::HTML(URI.open("http://www.annuaire-des-mairies.com#{cities_url_good_element}"))
  cities_mail_list = city_page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').children.text
  cities_mail << cities_mail_list
  #p cities_mail
end

names_and_mails = Hash[cities_name.zip(cities_mail)]

puts names_and_mails