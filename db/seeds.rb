# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



5.times do |i|
  Publishing.create(video: "video #{i}", title: "title #{i}", description: "Description #{i}", status: "publicado", uid: i)
end

5.times do |i|
  Channel.create(name: "My #{i} Channel")
end
