Item.delete_all
Category.delete_all
User.delete_all
Type.delete_all
Note.delete_all

jason = User.create :first_name => "Jason", :last_name => "Edelstein", :created_on => DateTime.new(2015, 7, 29), :admin => true, :admin_level => 2
thalia = User.create :first_name => "Thalia", :last_name => "Kapica", :created_on => DateTime.new(2015, 7, 29), :admin => false, :admin_level => 0

puts "There are now #{User.count} users in the database."

laptopcat = Category.create :name => "Laptops", :replacement_cost => 1500
ipadcat = Category.create :name => "iPads", :replacement_cost => 900
adaptercat = Category.create :name => "Power Adapters", :replacement_cost => 90

puts "There are now #{Category.count} categories in the database."

adaptertype = Type.create :name => "8 Hour Adapter Borrow", :borrow_duration => "8", :late_fee => 10
laptoptype = Type.create :name => "8 Hour Laptop Borrow", :borrow_duration => "8", :late_fee => 20
ipadtype = Type.create :name => "8 Hour iPad Borrow", :borrow_duration => "8", :late_fee => 15

puts "There are now #{Type.count} types in the database."

ms2 = Item.create :name => "MagSafe2 Power Adapter", :barcode => "096037900", :borrow_count => 4, :category_id => adaptercat.id, :type_id => adaptertype.id, :borrower_id => nil, :created_on => DateTime.new(2015, 8, 2), :creator_id => jason.id
ms1 = Item.create :name => "MagSafe1 Power Adapter", :barcode => "096037911", :borrow_count => 3, :category_id => adaptercat.id, :type_id => adaptertype.id, :borrower_id => nil, :created_on => DateTime.new(2015, 8, 2), :creator_id => jason.id
dell = Item.create :name => "Dell XPS laptop", :barcode => "107000319", :borrow_count => 0, :category_id => laptopcat.id, :type_id => laptoptype.id, :borrower_id => nil, :created_on => DateTime.new(2015, 8, 2), :creator_id => jason.id
mac = Item.create :name => "MacBook Air 13", :barcode => "106050367", :borrow_count => 10, :category_id => laptopcat.id, :type_id => laptoptype.id, :borrower_id => thalia.id, :status => 1, :created_on => DateTime.new(2015, 8, 2), :creator_id => jason.id
ipad = Item.create :name => "iPad Air", :barcode => "095082401",  :borrow_count => 1, :category_id => ipadcat.id, :type_id => ipadtype.id, :borrower_id => jason.id, :status => 1, :created_on => DateTime.new(2015, 8, 2), :creator_id => jason.id

puts "There are now #{Item.count} items in the database."

Note.create :text => "This is a note for a Dell laptop.", :item_id => dell.id, :created_on => DateTime.new(2015, 8, 2), :creator_id => jason.id

Note.create :text => "This is a note for a Mac laptop.", :item_id => mac.id, :created_on => DateTime.new(2015, 8, 2), :creator_id => jason.id

Note.create :text => "This is a note for an iPad.", :item_id => ipad.id, :created_on => DateTime.new(2015, 8, 2), :creator_id => jason.id

Note.create :text => "This is a note for an MS1 adapter.", :item_id => ms1.id, :created_on => DateTime.new(2015, 8, 2), :creator_id => jason.id

Note.create :text => "This is a note for an MS2 adapter.", :item_id => ms2.id, :created_on => DateTime.new(2015, 8, 2), :creator_id => jason.id

puts "There are now #{Note.count} notes in the database."

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
