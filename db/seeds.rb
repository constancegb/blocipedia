require 'random_data'

 # Create Users
 10.times do
   User.create!(
     name:     RandomData.random_name,
     email:    RandomData.random_email,
     password: RandomData.random_sentence
   )
 end
 users = User.all

 # Create Wikis
 50.times do
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
