require 'httparty'
require 'nokogiri'
require 'pry'
require 'csv'
require 'capybara'
require 'uri'
require 'net/http'
require 'sequel'
require 'sqlite3'

database = Sequel.sqlite('database.sqlite3')
items = database[:products]
current_dir = Dir.pwd

def create_directory(dirname)
  Dir.chdir("files")
  unless Dir.exists?(dirname)
    Dir.mkdir(dirname)
  else
    puts "Skipping creating directory " + dirname + ". It already exists."
  end
end

def download(uri, filename)
  puts "Starting HTTP download for: " + uri.to_s
  http_object = Net::HTTP.new(uri.host, uri.port)
  begin
    http_object.start do |http|
      request = Net::HTTP::Get.new uri.request_uri
      http.read_timeout = 500
      http.request request do |response|
        open filename, 'w' do |io|
          response.read_body do |chunk|
            io.write chunk
          end
        end
      end
    end
  rescue Exception => e
    puts "=> Exception: '#{e}'. Skipping download."
    return
  end
  puts "Stored download as " + filename + "."
end

def filename(original)
  name_of_file = original.gsub(/http.*abtronics_/, "")
end

def medium_image_name(original)
  image_medium = "medium_" + filename(original).to_s
end

def small_image_name(original)
  image_small = "small_" + filename(original).to_s
end

def uri_small(original)
  URI.parse(original)
end

def uri_medium(original)
  URI.parse(original.gsub("http://res.abtronics.ru//small", "http://res.abtronics.ru//medium"))
end

ident = 2

#link = 'http://abtronics.ru/components/ME92251V1000UA99_good_1490/'
link = 'http://abtronics.ru/components/MGDS3651500_good_1810922065/'
window = HTTParty.get(link)
page = Nokogiri::HTML(window)

CSV.open("test.csv", "w", {:col_sep => ";"}) do |csv|      

  comp, sh_categ, sh_man, link, name, category, manufact, short_descr, sklad, srok, quantity, price, description, image1, image2, image3, image4, image5, image6, image7, image8, image9, image10, pdf1, pdf2, pdf3, pdf4, pdf5, image1sf, image2sf, image3sf, image4sf, image5sf, image6sf, image7sf, image8sf, image9sf, image10sf, image1mf, image2mf, image3mf, image4mf, image5mf, image6mf, image7mf, image8mf, image9mf, image10mf, pdf1f, pdf2f, pdf3f, pdf4f, pdf5f = "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "" , "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""
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
            image6 = page.css('.gallery')[0].css('.thumb')[5].css('img')[0].attr('src').to_s
          rescue; end
          begin
            image7 = page.css('.gallery')[0].css('.thumb')[6].css('img')[0].attr('src').to_s
          rescue; end
          begin
            image8 = page.css('.gallery')[0].css('.thumb')[7].css('img')[0].attr('src').to_s
          rescue; end
          begin
            image9 = page.css('.gallery')[0].css('.thumb')[8].css('img')[0].attr('src').to_s
          rescue; end
          begin
            image10 = page.css('.gallery')[0].css('.thumb')[9].css('img')[0].attr('src').to_s
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

create_directory(ident.to_s)
Dir.chdir(ident.to_s)
puts "Changed directory: " + Dir.pwd

unless pdf1 == ""
  pdf1f = "1_" + filename(pdf1)
  url = uri_small(pdf1)
  download(url, pdf1f)
end

unless pdf2 == ""
  pdf2f = "2_" + filename(pdf2)
  url = uri_small(pdf2)
  download(url, pdf2f)
end

unless pdf3 == ""
  pdf3f = "3_" + filename(pdf3)
  url = uri_small(pdf3)
  download(url, pdf3f)
end

unless pdf4 == ""
  pdf4f = "4_" + filename(pdf4)
  url = uri_small(pdf4)
  download(url, pdf4f)
end


unless pdf5 == ""
  pdf5f = "5_" + filename(pdf5)
  url = uri_small(pdf5)
  download(url, pdf5f)
end


unless image1 == ""
  image1sf = "1_" + small_image_name(image1)
  image1mf = "1_" + medium_image_name(image1)
  uri_s = uri_small(image1)
  uri_m = uri_medium(image1)
  download(uri_s, image1sf)
  download(uri_m, image1mf)
end

unless image2 == ""
  image2sf = "2_" + small_image_name(image2)
  image2mf = "2_" + medium_image_name(image2)
  uri_s = uri_small(image2)
  uri_m = uri_medium(image2)
  download(uri_s, image2sf)
  download(uri_m, image2mf)
end

unless image3 == ""
  image3sf = "3_" + small_image_name(image3)
  image3mf = "3_" + medium_image_name(image3)
  uri_s = uri_small(image3)
  uri_m = uri_medium(image3)
  download(uri_s, image3sf)
  download(uri_m, image3mf)
end

unless image4 == ""
  image4sf = "4_" + small_image_name(image4)
  image4mf = "4_" + medium_image_name(image4)
  uri_s = uri_small(image4)
  uri_m = uri_medium(image4)
  download(uri_s, image4sf)
  download(uri_m, image4mf)
end

unless image5 == ""
  image5sf = "5_" + small_image_name(image5)
  image5mf = "5_" + medium_image_name(image5)
  uri_s = uri_small(image5)
  uri_m = uri_medium(image5)
  download(uri_s, image5sf)
  download(uri_m, image5mf)
end

unless image6 == ""
  image6sf = "6_" + small_image_name(image6)
  image6mf = "6_" + medium_image_name(image6)
  uri_s = uri_small(image6)
  uri_m = uri_medium(image6)
  download(uri_s, image6sf)
  download(uri_m, image6mf)
end

unless image7 == ""
  image7sf = "7_" + small_image_name(image7)
  image7mf = "7_" + medium_image_name(image7)
  uri_s = uri_small(image7)
  uri_m = uri_medium(image7)
  download(uri_s, image7sf)
  download(uri_m, image7mf)
end

unless image8 == ""
  image8sf = "8_" + small_image_name(image8)
  image8mf = "8_" + medium_image_name(image8)
  uri_s = uri_small(image8)
  uri_m = uri_medium(image8)
  download(uri_s, image8sf)
  download(uri_m, image8mf)
end

unless image9 == ""
  image9sf = "9_" + small_image_name(image9)
  image9mf = "5_" + medium_image_name(image9)
  uri_s = uri_small(image9)
  uri_m = uri_medium(image9)
  download(uri_s, image9sf)
  download(uri_m, image9mf)
end

unless image10 == ""
  image10sf = "10_" + small_image_name(image10)
  image10mf = "10_" + medium_image_name(image10)
  uri_s = uri_small(image10)
  uri_m = uri_medium(image10)
  download(uri_s, image10sf)
  download(uri_m, image10mf)
end


  csv << [ident, comp, sh_categ, sh_man, link, name, category, manufact, short_descr, sklad, srok, quantity, price, description, image1, image2, image3, image4, image5, image6, image7, image8, image9, image10, pdf1, pdf2, pdf3, pdf4, pdf5, image1sf, image2sf, image3sf, image4sf, image5sf, image6sf, image7sf, image8sf, image9sf, image10sf, image1mf, image2mf, image3mf, image4mf, image5mf, image6mf, image7mf, image8mf, image9mf, image10mf, pdf1f, pdf2f, pdf3f, pdf4f, pdf5f]

Dir.chdir(current_dir)

  items.insert(:ident => ident, :comp => comp, :sh_categ => sh_categ, :sh_man => sh_man, :link => link, :name => name, :category => category, :manufact => manufact, :short_descr => short_descr, :sklad => sklad, :srok => srok, :quantity => quantity, :price => price, :description => description, :image1 => image1, :image2 => image2, :image3 => image3, :image4 => image4, :image5 => image5, :image6 => image6, :image7 => image7, :image8 => image8, :image9 => image9, :image10 => image10, :pdf1 => pdf1, :pdf2 => pdf2, :pdf3 => pdf3, :pdf4 => pdf4, :pdf5 => pdf5, :image1sf => image1sf, :image2sf => image2sf, :image3sf => image3sf, :image4sf => image4sf, :image5sf => image5sf, :image6sf => image6sf, :image7sf => image7sf, :image8sf => image8sf, :image9sf => image9sf, :image10sf => image10sf, :image1mf => image1mf, :image2mf => image2mf, :image3mf => image3mf, :image4mf => image4mf, :image5mf => image5mf, :image6mf => image6mf, :image7mf => image7mf, :image8mf => image8mf, :image9mf => image9mf, :image10mf => image10mf, :pdf1f => pdf1f, :pdf2f => pdf2f, :pdf3f => pdf3f, :pdf4f => pdf4f, :pdf5f => pdf5f)

  puts items.select.to_a

end
