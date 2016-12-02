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
    sleep 10
    puts session.current_url
    1.upto(20).each do |i|
      puts i.to_s + " row"
      row = session.all(".search-result-table")[0].all('tr')[i]
comp, sh_categ, sh_man, link, name, category, manufact, short_descr, sklad, srok, quantity, price, description = "", "", "", "", "", "", "", "", "", "", "", "", "" 
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
        session.within_window session.open_new_window do
          session.visit(link)
          begin
            name = session.all('.details')[0].all('h1')[0].text
          rescue; end
          begin
            category = session.all('.details')[0].all('.category')[0].all('p')[0].text
          rescue; end
          begin
            manufact = session.all('.details')[0].all('.manufacturer')[0].all('p')[0].text
          rescue; end
          begin
            short_descr = session.all('.details')[0].all('.short-desc')[0].text
          rescue; end
          begin
            sklad = session.all('.stock-td')[0].text
          rescue; end
          begin
            srok = session.all('.delivery-td')[0].text
          rescue; end
          begin
            quantity = session.all('.avail-td')[0].text
          rescue; end
          begin
            price = session.all('.price-td')[0].text
          rescue; end
          begin
            description = session.all('.attrlist')[0].text        
          rescue; end
          csv << [comp, sh_categ, sh_man, link, name, category, manufact, short_descr, sklad, srok, quantity, price, description]
          session.driver.close_window(session.driver.current_window_handle)
        end
      rescue; end
    end
  end
end


