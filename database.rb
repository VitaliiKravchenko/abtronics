require 'sequel'
require 'sqlite3'
require 'paperclip'
database = Sequel.sqlite('database.sqlite3')
#database.run "CREATE TABLE products (id integer primary key autoincrement, comp, sh_categ, sh_man, link, name, category, manufact, short_descr, sklad, srok, quantity, price, description, image1, image2, image3, image4, image5, pdf1, pdf2, pdf3, pdf4, pdf5)"

items = database[:products]
puts items.select.to_a

#items.truncate
