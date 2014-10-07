# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

beer_names=[
  "Hop Destruction",
  "Palate Ruiner",
  "Duff Dry",
  "Pale Male",
  "Bartles & James",
  "Le Fin du Luther",
  "Stella (You know, the Italian beer)"
]

game_names=[
  "Super Smash Luthers",
  "Strip Corys",
  "Oakley Command",
  "Chest",
  "CarnEVIL",
  "Burger Boss",
  "Zoltar"
]

pizza_names=[
  "Jimmy Buffett",
  "Magnum",
  "Q-Bert",
  "Robotron",
  "Tempest",
  "VanDam",
  "Morrissey"
]
subtitles=[
  "Donec sed pharetra augue. Fusce porttitor condimentum magna non rutrum. Vestibulum nec mi nulla. Nam.",
  "Pellentesque condimentum massa vitae laoreet sagittis. Nam lobortis arcu ut tortor elementum convallis. Praesent semper.",
  "Phasellus scelerisque, tellus quis pellentesque egestas, arcu arcu dictum erat, sed pretium ipsum nibh id.",
  "Pellentesque pellentesque lobortis magna, sit amet aliquam tortor venenatis vitae. Nam at vulputate elit. Morbi.",
  "Sed nec posuere metus. Nulla efficitur vel est sit amet auctor. Mauris finibus gravida dictum."
]
description=[
  "<p>Vestibulum laoreet, risus ut imperdiet egestas, nibh nisi mattis justo, vitae aliquam leo elit vel est. Suspendisse quis pulvinar augue. Sed imperdiet sapien nisl, vehicula luctus dolor feugiat a. Proin at lacinia justo, in fringilla diam. Nullam sit amet metus.</p>",
  "<p>Interdum et malesuada fames ac ante ipsum primis in faucibus. Nulla rutrum vulputate urna ac imperdiet. Nam sed felis convallis, euismod dolor feugiat, semper erat. Praesent sed purus mi. Nunc cursus elit sed interdum bibendum. Sed in nibh eu erat.</p>",
  "<p>Pellentesque congue lectus nisl, eu fermentum velit volutpat ut. Sed lacinia auctor vestibulum. Aliquam tempor ligula in justo pellentesque, vel varius eros bibendum. In ut sapien vel turpis gravida auctor non ac mi. Donec feugiat, neque et vestibulum interdum, tortor.</p>",
  "<p>Mauris ac accumsan orci. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam finibus bibendum turpis, sit amet varius urna varius et. Etiam faucibus pellentesque aliquam. Etiam a tincidunt odio. Aliquam pellentesque eros lorem, vehicula sodales mi vehicula quis. Aenean.</p>"
]
game_images = Dir::entries("#{Rails.root}/db/images/game").reject{|i| i == "." || i == ".."}
beer_images = Dir::entries("#{Rails.root}/db/images/beer").reject{|i| i == "." || i == ".."}
pizza_images = Dir::entries("#{Rails.root}/db/images/pizza").reject{|i| i == "." || i == ".."}
data = {
  pizza:{names:pizza_names,images:pizza_images},
  beer:{names:beer_names,images:beer_images},
  game:{names:game_names,images:game_images},
}
Product.delete_all
data.each_pair do |type, hash|
  names = hash[:names].dup
  images = hash[:images].dup
  12.times do |i|
    category = (i < 6)? 1:2
    r = Random.new
    names = hash[:names].dup if names.empty?
    images = hash[:images].dup if images.empty?
    n_index = r.rand(0..names.length-1)
    i_index = r.rand(0..images.length-1)
    sub_index = r.rand(0..subtitles.length-1)
    desc_index = r.rand(0..description.length-1)
    name= names.delete_at(n_index)
    img = images.delete_at(i_index)
    sub = subtitles[sub_index]
    desc = description[desc_index]
    p = Product.create(
      title:name,
      subtitle:sub,
      description:desc,
      visible:true,
      type:type.capitalize.to_s,
      image:File.open("#{Rails.root}/db/images/#{type.to_s}/#{img}"),
      category:category
    )
    puts p
  end
end
feature = Game.last
feature.featured = true
feature.save!

feature = Pizza.last
feature.featured = true
feature.save!

feature = Beer.last
feature.featured = true
feature.save!
