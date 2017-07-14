require 'random_data'

 # Create Users (will be standard by default)
 10.times do
   User.create!(
     name:     RandomData.random_name,
     email:    RandomData.random_email,
     password: RandomData.random_sentence
   )
 end


 #Create a preium user
 premium = User.create!(
   name:     'Premium User',
   email:    'premium@example.com',
   password: 'helloworld',
   role:     'premium'
 )

 #Create an admin user
 admin = User.create!(
   name:     'Admin User',
   email:    'admin@example.com',
   password: 'helloworld',
   role:     'admin'
 )
 users = User.all

 # Create Wikis
 55.times do
   Wiki.create!(
     user:   users.sample,
     title:  RandomData.random_sentence,
     body:   RandomData.random_paragraph,
     private: false
   )
 end

 puts "Seed finished"
 puts "#{User.count} users created"
 puts "#{Wiki.count} wikis created"
