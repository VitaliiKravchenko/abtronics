require 'sequel'
require 'sqlite3'
database = Sequel.sqlite('database.sqlite3')
#database.drop_table('products')
database.run "CREATE TABLE products (id integer primary key autoincrement,ident integer, comp, sh_categ, sh_man, link, name, category, manufact, short_descr, sklad, srok, quantity, price, description, image1, image2, image3, image4, image5, image6, image7, image8, image9, image10, pdf1, pdf2, pdf3, pdf4, pdf5, image1sf, image2sf, image3sf, image4sf, image5sf, image6sf, image7sf, image8sf, image9sf, image10sf, image1mf, image2mf, image3mf, image4mf, image5mf, image6mf, image7mf, image8mf, image9mf, image10mf, pdf1f, pdf2f, pdf3f, pdf4f, pdf5f)"

items = database[:products]
#items.insert(:ident => ident, :comp => comp, :sh_categ => sh_categ, :sh_man => sh_man, :link => link, :name => name, :category => category, :manufact => manufact, :short_descr => short_descr, :sklad => sklad, :srok => srok, :quantity => quantity, :price => price, :description => description, :image1 => image1, :image2 => image2, :image3 => image3, :image4 => image4, :image5 => image5, :pdf1 => pdf1, :pdf2 => pdf2, :pdf3 => pdf3, :pdf4 => pdf4, :pdf5 => pdf5, :image1sf => image1sf, :image2sf => image2sf, :image3sf => image3sf, :image4sf => image4sf, :image5sf => image5sf, :image1mf => image1mf, :image2mf => image2mf, :image3mf => image3mf, :image4mf => image4mf, :image5mf => image5mf, :pdf1f => pdf1f, :pdf2f => pdf2f, :pdf3f => pdf3f, :pdf4f => pdf4f, :pdf5f => pdf5f)
puts items.select.to_a

#items.truncate
