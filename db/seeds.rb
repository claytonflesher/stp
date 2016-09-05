# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

<<<<<<< HEAD

 Therapist.create!(
=======
   
     Therapist.create!(
>>>>>>> 54353bb30f8e588e09b48aadb7274668b365c3c7
     :username => 'testuser1',
     :password =>'Welcome1',
     :password_confirmation => 'Welcome1',
     :first_name => 'Daniel',
     :last_name => 'Ashcraft',
     :address => '22 some address',
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
     :geo_address => '22 some address',
     :super_admin => 'true',
     :application_status => 'active',
     :verified_at => Time.now.to_datetime,
     :verification_token => 'abcdefghijklmnop',
     :zipcode => 73112,
     :email => 'testemail1@email.com',
     :phone => '4055555555'
     )
<<<<<<< HEAD
     
     
=======
 
    Patient.create!(
     :username => 'testpatient1',
     :password =>'Welcome1',
     :password_confirmation => 'Welcome1',
     :name => 'Daniel Ashcraft',
     :former_religion=> 'Atheist',
     :description => 'This is the description',
     :gender => 'Male',
     :verified_at => Time.now.to_datetime,
     :verification_token => 'abcdefghijklmnolll',
     :zipcode => 73112,
     :email => 'testemail1@email.com',
     :phone => '4055555555',
     :longitude => '35.4676',
     :latitude =>'97.5164',
     :created_at=>Time.now.to_datetime,
     :updated_at=>Time.now.to_datetime
     
     )
   
   
>>>>>>> 54353bb30f8e588e09b48aadb7274668b365c3c7
   
