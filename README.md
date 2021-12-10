# BRAINWASH

## Introduction
---
Over the last few years, while working through the pandemic, we’ve been spending a lot more time at home and people have turned to social media to stay connected with others to fill that extra time.

As we know, many of the popular social media platforms, like Instagram and TikTok, have been proven to be quite detrimental to our mental health, so we wanted to create a platform which would foster a healthier online community where people can connect with others in a social context, all while consuming more positive content.

Users come to Brainwash to learn new skills, improve existing passions, and share their own knowledge through various media types with an online community of other passionate lifelong learners - Think master class meets instagram & youtube.

Brainwash is our submission for the final project for the lighthouse labs web development bootcamp. Over an enjoyable 10 days, the creators: Russell Engebretson, Sophie Oliver and Katie Herda, worked together to build out an MVP of the platform, expanding on knowledge learned in the bootcamp, to add functionality that would allow users to create and consume content, and communicate with other Brainwashers.

## Live Server
We have launched our app live using Heroku, and it can be accessed at [https://brainwash-ify-ology.herokuapp.com/](https://brainwash-ify-ology.herokuapp.com/)

## Features
---
### Log in/out
- log in using either your Google or Github account
- This login will pull data from your social account, including email and your social avatar
- signing in will create a local user for you which is customizable (see profile page section)
- you can then use all features of our site
- log out simply by clicking log out

### Index Page

When you arrive on our site you will be on the main index page. This page has the following features:

- List of the most recent posts by other users
- Save posts to learn more about the topics later by browsing through the posts and liking them
- Toggle to your liked posts by selecting the "Liked posts" tab in the top right
- Click on a post to go to the post show page where you can view details about the lesson, and watch any audio or video files attached to it
- Search by title
- Filter by your interests
- Click on the "New Post" button to create your own post

### Post Show

When you click on a post, it will take you to the Post Show page, where you can:

- Watch the Audio or Video file
- Read the description
- Like/unlike the post
- Leave a comment on the post
- Delete any of YOUR comments on the post
- Navigate to the profile page of the Poster or any of the commentors

### Profile Page

There are two profile pages on our site, one for yourself and one for any other user. To access YOUR page, click your avatar/username in the top right of the Navbar next to the Log out button

Here you will see your profile along with an index of all of YOUR posts, where you can:
- view your follower/following counts
- view profile info (username, bio, avatar)
- edit your profile (change name, username, bio and avatar)
- Search through your posts by title
- filter your posts by interests
- create a new post

You can also view other people's profile pages by clicking on their usernames on either their posts, or in their comments. Here you can:

- View their profile
- View all the posts created by them
- follow/unfollow
- view any of their posts which you liked
- search by title, filter by your interests
- create a new post

### Create Post

On this page you can create your own post:

- Add a title, description, post type (Audio/video), main category (interest)
- Choose a thumbnail image
- Choose a post file (audio/video)
- Create and save files to the cloud


## Repository
---
This is the back end repository for our app, if you would like to view the front end React repo click [Brainwash](https://github.com/rengebre/brainwash-ify-ology)

We built the back end using a Ruby on Rails API, with active record running a postgres database for user and post data, along with a combination of active storage and Cloudinary to allow for storing video, audio and image files to the cloud.

With the short 10 day timeline for producing the platform, there are several inneficiencies with the layout of our backend, but for a proof of concept we feel it works quite well. Updates to come, time permitted:

- refactor several returned data structures from arrays to hashes or JSON objects for easier data management on the front end
- reduce the number of queries to our database
- namespace all our routes with `/api/*`
- update how we fetch active storage urls using cloudinary. We currently fetch the cloudinary url every time we want to retrieve a file, which will be a slow process communicating with a cloud server. Instead we should have the cloudinary url returned on creation or update of an attachment and store that static url in our respective postgres database tables for faster retrieval times
- all Auth0 is done on the front end using social logins and authentication, it would be nice to fully authenticate the backend as well.


## Project Layout
---
This application follows the typical Ruby on Rails folder structure, except we built it using Rails API, so our controllers inherit `ActionController::API`.

# Running the Repo locally for development

Install Ruby 3.0.2, and rails 6.1.4.1

Create a postgres DB and sign up for a Cloudinary account.

Create a config/database.yml file with the following skeleton:
```rb
development:
  adapter: postgresql
  encoding: unicode
  database: [your db name here]
  pool: 5
  username: [your db username]
  password: [your db password]
  timeout: 5000
```

create a .env file in the root directory with the following skeleton:
```rb
CLOUD_NAME=[your cloudinary name here]
CL_API_KEY=[your cloudinary API key here]
CL_API_SECRET=[your cloudinary secret here]
```

install dependencies:

```rb
bundle install
```

populate populate your db:
```rb
rails db:reset
```
Run server
```rb
bin/rails server
```

The server should start on localhost port 3000.
