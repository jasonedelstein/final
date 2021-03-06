Item.delete_all
Category.delete_all
User.delete_all
Type.delete_all
Note.delete_all
Accessory.delete_all
Kit.delete_all

puts "The database just died, man. GAME OVER! GAME OVER!"

case_accessory = Accessory.create :name => "Laptop case"
carrying_bag_accessory = Accessory.create :name => "Carrying bag"
camera_lens_accessory = Accessory.create :name => "Camera lens kit"

puts "There are now #{Accessory.count} accessories in the database."

jason = User.create :first_name => "Jason", :last_name => "Edelstein", :created_on => DateTime.new(2015, 7, 29), :admin => true, :password => "jasone", :email => "jasone@uchicago.edu"
thalia = User.create :first_name => "Thalia", :last_name => "Kapica", :created_on => DateTime.new(2015, 7, 29), :admin => false, :password => "jasone", :email => "baigan@gmail.com"
randomguy = User.create :first_name => "Random", :last_name => "Guy", :created_on => DateTime.new(2015, 7, 29), :admin => false, :password => "jasone", :email => "jason.b.edelstein@gmail.com"
randomgal = User.create :first_name => "Random", :last_name => "Gal", :created_on => DateTime.new(2015, 7, 29), :admin => false, :password => "jasone", :email => "fake@fake.com"
thatperson = User.create :first_name => "That", :last_name => "Person", :created_on => DateTime.new(2015, 7, 29), :admin => false, :password => "jasone", :email => "reallyfake@fake.com"

puts "There are now #{User.count} users in the database."

laptopcat = Category.create :name => "Laptops", :replacement_cost => 1500
ipadcat = Category.create :name => "iPads", :replacement_cost => 900
adaptercat = Category.create :name => "Power Adapters", :replacement_cost => 90
cameracat = Category.create :name => "Cameras", :replacement_cost => 700
videocat = Category.create :name => "Video Equipment", :replacement_cost => 1000

puts "There are now #{Category.count} categories in the database."

adaptertype = Type.create :name => "8 Hour Adapter Borrow", :borrow_duration => "8", :late_fee => 10
laptoptype = Type.create :name => "8 Hour Laptop Borrow", :borrow_duration => "8", :late_fee => 20
ipadtype = Type.create :name => "8 Hour iPad Borrow", :borrow_duration => "8", :late_fee => 15
cameratype = Type.create :name => "8 Hour Camera Borrow", :borrow_duration => "8", :late_fee => 10
videotype = Type.create :name => "8 Hour Video Borrow", :borrow_duration => "8", :late_fee => 15

puts "There are now #{Type.count} types in the database."

ms2 = Item.create :name => "MagSafe2 Power Adapter", :barcode => "096037900", :borrow_count => 4, :category_id => adaptercat.id, :type_id => adaptertype.id, :borrower_id => nil, :created_on => DateTime.new(2015, 8, 2), :creator_id => jason.id
ms1 = Item.create :name => "MagSafe1 Power Adapter", :barcode => "096037911", :borrow_count => 3, :category_id => adaptercat.id, :type_id => adaptertype.id, :borrower_id => nil, :created_on => DateTime.new(2015, 8, 2), :creator_id => jason.id
dell = Item.create :name => "Dell XPS laptop", :barcode => "107000319", :borrow_count => 0, :category_id => laptopcat.id, :type_id => laptoptype.id, :borrower_id => nil, :created_on => DateTime.new(2015, 8, 2), :creator_id => jason.id
mac = Item.create :name => "MacBook Air 13", :barcode => "106050367", :borrow_count => 10, :category_id => laptopcat.id, :type_id => laptoptype.id, :borrower_id => thalia.id, :status => 1, :created_on => DateTime.new(2015, 8, 2), :creator_id => jason.id, :due_time => DateTime.new(2015, 8, 4)
ipad = Item.create :name => "iPad Air", :barcode => "095082401",  :borrow_count => 1, :category_id => ipadcat.id, :type_id => ipadtype.id, :borrower_id => jason.id, :status => 1, :created_on => DateTime.new(2015, 8, 2), :creator_id => jason.id, :due_time => DateTime.new(2016, 8, 4)

puts "There are now #{Item.count} items in the database."

kit_dell_case = Kit.create :item_id => dell.id, :accessory_id => case_accessory.id
kit_mac_case = Kit.create :item_id => mac.id, :accessory_id => case_accessory.id
kit_mac_bag = Kit.create :item_id => mac.id, :accessory_id => carrying_bag_accessory.id
kit_ipad_case = Kit.create :item_id => ipad.id, :accessory_id => carrying_bag_accessory.id
kit_dell_bag = Kit.create :item_id => dell.id, :accessory_id => carrying_bag_accessory.id

puts "There are now #{Kit.count} kits in the database."

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
