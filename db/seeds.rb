# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

####### USERS #######

user_list = [
  {
    email: "russell.engebretson@gmail.com",
    name: "Russell E",
    username: "russell.engebretson",
    bio: "super dooper cool",
    social_img: "https://lh3.googleusercontent.com/a-/AOh14Gj3fDPkuWQWWXIy9nO14V0UOxDnT9DP4I0zSftenA=s96-c",
    social_id: "google-oauth2|114665092879259846710"
  },
  {
    email: "katie.herda2@gmail.com",
    name: "Katie Herda",
    username: "katie.herda2",
    bio: "I like skittles",
    active: true,
    social_img: "https://lh3.googleusercontent.com/a-/AOh14GhyUIB6h_-z3091w2VCK1WNlbVy6R8J8vge03cfvQ=s96-c",
    social_id: "google-oauth2|111598822118906167947"
  },
  {
    email: "sophiejoliver19@gmail.com",
    name: "Sophie Oliver",
    username: "sophiejoliver19",
    bio: "gare af - you either scam today, or today scams you",
    social_img: "https://lh3.googleusercontent.com/a-/AOh14GhC2f6PLN3nzaEz3QbZ4XBxvqJiGi9t-Bi5SSXh=s96-c",
    social_id: "google-oauth2|106129642574534830090"
  }
]

# User.destroy_all

user_list.each {|user|
  User.create!(user)
}

####### INTERESTS #######

interest_list = [
  {
    name: 'Cooking'
  },
  {
    name: 'Home Improvements'
  },
  {
    name: 'Gardening'
  }
]

# Interest.destroy_all

interest_list.each { |interest| Interest.create!(interest) }

####### USER_INTERESTS #######

user_interest_list = [
  {
    user_id: 1,
    interest_id: 1
  },
  {
    user_id: 2,
    interest_id: 2
  },
  {
    user_id: 3,
    interest_id: 3
  },
  {
    user_id: 1,
    interest_id: 3
  },
  {
    user_id: 2,
    interest_id: 2
  },
  {
    user_id: 3,
    interest_id: 1
  }
]

# UserInterest.destroy_all

user_interest_list.each { |user_interest| UserInterest.create!(user_interest) }

####### POSTS #######

post_list = [
  {
    title: "How to cook a sweet potato",
    description: "Watch me cook this huge sweet potato, she is so sweet",
    # upload_file: "https://video-images.vice.com/articles/5a4d3c2c195444648780c02a/lede/1515013133112-Screen-Shot-2018-01-03-at-35241-PM.png?crop=0.9197530864197531xw:1xh;center,center&resize=1200:*",
    post_type: "video",
    user_id: 1,
    interest_id: 1
  },
  {
    title: "How to tear out your nasty carpets",
    description: "Let me walk you through the best way to rip out your old carpets to reveal the beautiful hardwood",
    # upload_file: "https://www.thespruce.com/thmb/suvSBIM8DxtFvsWYkOtB64BefuY=/1885x1414/smart/filters:no_upscale()/RemovingCarpet-6a4a6a6f78df40d8a11439e6a83ec866.jpg",
    post_type: "video",
    user_id: 2,
    interest_id: 2
  },
  {
    title: "How to revive an aloe plant",
    description: "Everything you need to know about keeping your precious aloe bbs alive and juicy",
    # upload_file: "https://i.ytimg.com/vi/kHsQYCM_sQs/maxresdefault.jpg",
    post_type: "video",
    user_id: 3,
    interest_id: 3
  }
]

# # Posts.destroy_all
i = 0
post_list.each { |post| 
  i += 1
  @post = Post.create!(post) 
  @post.thumbnail.attach(io: File.open(Rails.root.join("db", "seed-images", "image#{i}.png").to_s), filename:"image#{i}.png")
}


###### LIKES ######

likes_list = [
  {
    user_id: 1,
    post_id: 2
  },
  {
    user_id: 2,
    post_id: 3
  },
  {
    user_id: 3,
    post_id: 1
  }
]

likes_list.each { |like| Like.create!(like)}

###### COMMENTS ######

comments_list = [
  {
    content: 'love this vid, thanks for sharing!!',
    user_id: 1,
    post_id: 2
  },
  {
    content: 'learned so much, vid was sweeeet',
    user_id: 2,
    post_id: 3
  },
  {
    content: '5 stars, would watch again!',
    user_id: 3,
    post_id: 1
  }
]

comments_list.each { |comment| Comment.create!(comment) }

###### FOLLOWS ######

follows_list = [
  {
    followed_id: 1,
    follower_id: 2
  },
  {
    followed_id: 2,
    follower_id: 3
  },
  {
    followed_id: 3,
    follower_id: 1
  }
]

follows_list.each { |follow| Follow.create!(follow) }