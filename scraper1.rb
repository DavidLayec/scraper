require 'nokogiri'
require 'open-uri'
require 'pry'
require 'json'

def scrape_mairie_urls
  pages_urls = []
  i = 1
  until i > 34
    pages_url = "xx"
    pages_urls << pages_url
  end

  mairie_urls = []

  pages_urls.each do |pages_url|
    html = open(pages_url)
    doc = Nokogiri::HTML(html)
    mairies = doc.css('.line').search('td:nth-child(n)').css('.fontBlue>a')

    mairies.each do |mairie|
      url = mairie.attribute('href').value
      mairie_urls << url
    end
    scrape_mairie_pages(mairie_urls)
  end
end

def scrape_mairie_pages(mairie_urls)
  mairie_mails = []
  mairie_urls.each do |mairie_url|
    url = "#{mairie_url}"
    html = open(url)
    doc = Nokogiri::HTML(html)
    td = doc.css('.mairieTable').search(':nth-child(n)').search('td:nth-child(n)').text
    if td.include?('email')
      first_s = td.split('email :')
      second_s = first_s[1].split('Region')
      mail = second_s[0]
    else
      mail = 'Mail not included'
    end
    mairie_mails << mail
  end
  p mairie_mails
end
scrape_mairie_urls
