# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user_list = [
  {
    email: "russell@email.com",
    name: "Russell Engebretson",
    username: "rengebre",
    bio: "super dooper cool",
    active: true,
    avatar: "/russell.png"
  },
  {
    email: "katie@email.com",
    name: "Katie Herda",
    username: "kherds",
    bio: "I like skittles",
    active: true,
    avatar: "/katie.png"
  },
  {
    email: "sophie@email.com",\
    name: "Sophie Oliver",
    username: "sjoliver",
    bio: "gare af - you either scam today, or today scams you",
    active: true,
    avatar: "/sophie.png"
  }
]

User.destroy_all

user_list.each {|user|
  User.create!(user)
}



