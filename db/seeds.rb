# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


 Therapist.create!(
     :username => 'testuser1',
     :password =>'Welcome1',
     :password_confirmation => 'Welcome1',
     :first_name => 'Daniel',
     :last_name => 'Ashcraft',
     :address => '2236 carlton way',
     :city => 'Oklahoma City',
     :state => 'Oklahoma',
     :country => 'United States',
     :practice => 'Therapy',
     :years_experience => 10,
     :qualifications => 'Too many to list',
     :gender => 'Male',
     :religion => 'Atheist',
     :licenses => 'Oklahoma state Therapist License #001',
     :main_license => 'Oklahoma state Therapist License #001',
     :distance_counseling => 'true',
     :purpose => 'To help people',
     :geo_address => '2236 calront way',
     :super_admin => 'true',
     :application_status => 'active',
     :verified_at => Time.now.to_datetime,
     :verification_token => 'abcdefghijklmnop',
     :zipcode => 73120,
     :email => 'testemail1@email.com',
     :phone => '4054461822'
     )
   
