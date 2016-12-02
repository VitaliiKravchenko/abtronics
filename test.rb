require 'httparty'
require 'nokogiri'
require 'json'
require 'pry'
require 'csv'
require 'mechanize'
require 'capybara'
require 'uri'
require 'net/http'


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


link = 'http://abtronics.ru/components/MEC0252V10000A99_good_14'
window = HTTParty.get(link)
page = Nokogiri::HTML(window)

CSV.open("test.csv", "w", {:col_sep => ";"}) do |csv|      

  comp, sh_categ, sh_man, link, name, category, manufact, short_descr, sklad, srok, quantity, price, description, image1, image2, image3, image4, image5, pdf1, pdf2, pdf3, pdf4, pdf5, image1sf, image2sf, image3sf, image4sf, image5sf, image1mf, image2mf, image3mf, image4mf, image5mf, pdf1f, pdf2f, pdf3f, pdf4f, pdf5f = "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "" , "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""
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


create_directory(ident.to_s)
Dir.chdir(ident.to_s)
puts "Changed directory: " + Dir.pwd

unless pdf1 == ""
  pdf1f = filename(pdf1)
  download_pdf(pdf1, pdf1f)
end

unless pdf2 == ""
  pdf1f = filename(pdf2)
  download_pdf(pdf2, pdf2f)
end

unless pdf3 == ""
  pdf1f = filename(pdf3)
  download_pdf(pdf3, pdf13)
end

unless pdf4 == ""
  pdf1f = filename(pdf4)
  download_pdf(pdf4, pdf14)
end


unless pdf5 == ""
  pdf5f = filename(pdf5)
  download_pdf(pdf5, pdf5f)
end


unless image1 == ""
  image1sf = small_image_name(image1)
  image1mf = medium_image_name(image1)
  uri_s = uri_small(image1)
  uri_m = uri_medium(image1)
  download(uri_s, image1sf)
  download(uri_m, image1mf)
end

unless image2 == ""
  image2sf = small_image_name(image2)
  image2mf = medium_image_name(image2)
  uri_s = uri_small(image2)
  uri_m = uri_medium(image2)
  download(uri_s, image2sf)
  download(uri_m, image2mf)
end

unless image3 == ""
  image3sf = small_image_name(image3)
  image3mf = medium_image_name(image3)
  uri_s = uri_small(image3)
  uri_m = uri_medium(image3)
  download(uri_s, image3sf)
  download(uri_m, image3mf)
end

unless image4 == ""
  image4sf = small_image_name(image4)
  image4mf = medium_image_name(image4)
  uri_s = uri_small(image4)
  uri_m = uri_medium(image4)
  download(uri_s, image4sf)
  download(uri_m, image4mf)
end


unless image5 == ""
  image5sf = small_image_name(image5)
  image5mf = medium_image_name(image5)
  uri_s = uri_small(image5)
  uri_m = uri_medium(image5)
  download(uri_s, image5sf)
  download(uri_m, image5mf)
end



          csv << [ident, comp, sh_categ, sh_man, link, name, category, manufact, short_descr, sklad, srok, quantity, price, description, image1, image2, image3, image4, image5, pdf1, pdf2, pdf3, pdf4, pdf5, image1sf, image2sf, image3sf, image4sf, image5sf, image1mf, image2mf, image3mf, image4mf, image5mf, pdf1f, pdf2f, pdf3f, pdf4f, pdf5f]

end



