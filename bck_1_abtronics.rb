require 'httparty'
require 'nokogiri'
require 'json'
require 'pry'
require 'csv'
require 'mechanize'
require 'capybara'
require 'watir'

CSV.open("myfile.csv", "w", {:col_sep => ";"}) do |csv|
  Capybara.current_driver = :selenium
  session = Capybara::Session.new(:selenium)
  
  1.upto(50).each do |page|
    puts page.to_s + " page"
    session.reset_session!
    session.visit( "http://abtronics.ru/search/#filter_category=9&page=#{page}")
#Pry.start(binding)
    sleep 15
    puts session.current_url
    1.upto(20).each do |i|
      puts Time.now.to_s
      puts i.to_s + " row"
      row = session.all(".search-result-table")[0].all('tr')[i]
      comp, sh_categ, sh_man, link, name, category, manufact, short_descr, sklad, srok, quantity, price, description, image1, image2, image3, image4, image5, pdf1, pdf2, pdf3, pdf4, pdf5 = "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "" 
      begin 
        comp = row.all('.sres-comp')[0].all('a')[0].text
      rescue; end
      begin
        sh_categ = row.all('.sres-cat')[0].text
      rescue; end
      begin
        sh_man = row.all('.sres-man')[0].text
      rescue; end
      begin
        link = row.all('.sres-comp')[0].all('a')[0][:href]      
      rescue; end
      begin

          window = HTTParty.get(link)
          page = Nokogiri::HTML(window)
          begin
            name = page.css('.details')[0].css('h1')[0].text.gsub(/\s+/, ' ').strip
          rescue; end
          begin
            category = page.css('.details')[0].css('.category')[0].css('p')[0].text.gsub(/\s+/, ' ').strip
          rescue; end
          begin
            manufact = page.css('.details')[0].css('.manufacturer')[0].css('p')[0].text.gsub(/\s+/, ' ').strip
          rescue; end
          begin
            short_descr = page.css('.details')[0].css('.short-desc')[0].text.gsub(/\s+/, ' ').strip
          rescue; end
          begin
            sklad = page.css('.stock-td')[0].text.gsub(/\s+/, ' ').strip
          rescue; end
          begin
            srok = page.css('.delivery-td')[0].text.gsub(/\s+/, ' ').strip
          rescue; end
          begin
            quantity = page.css('.avail-td')[0].text.gsub(/\s+/, ' ').strip
          rescue; end
          begin
            price = page.css('.price-td')[0].text.gsub(/\s+/, ' ').strip
          rescue; end
          begin
            description = page.css('.attrlist')[0].text.gsub(/\s+/, ' ').strip
          rescue; end
          begin
            image1 = page.css('.gallery')[0].css('.thumb')[0].css('img')[0].attr('src').to_s
          rescue; end
          begin
            image2 = page.css('.gallery')[0].css('.thumb')[1].css('img')[0].attr('src').to_s
          rescue; end
          begin
            image3 = page.css('.gallery')[0].css('.thumb')[2].css('img')[0].attr('src').to_s
          rescue; end
          begin
            image4 = page.css('.gallery')[0].css('.thumb')[3].css('img')[0].attr('src').to_s
          rescue; end
          begin
            image5 = page.css('.gallery')[0].css('.thumb')[4].css('img')[0].attr('src').to_s
          rescue; end
          begin
            pdf1 = page.css('.attach')[0].css('a')[0].attr('href').to_s
          rescue; end
          begin
            pdf2 = page.css('.attach')[1].css('a')[0].attr('href').to_s
          rescue; end
          begin
            pdf3 = page.css('.attach')[2].css('a')[0].attr('href').to_s
          rescue; end
          begin
            pdf4 = page.css('.attach')[3].css('a')[0].attr('href').to_s
          rescue; end
          begin
            pdf5 = page.css('.attach')[4].css('a')[0].attr('href').to_s
          rescue; end
          
          csv << [comp, sh_categ, sh_man, link, name, category, manufact, short_descr, sklad, srok, quantity, price, description, image1, image2, image3, image4, image5, pdf1, pdf2, pdf3, pdf4, pdf5, "finish"]
      rescue; end
    end
  end
end


