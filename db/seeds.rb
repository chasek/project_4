# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
User.create(:first_name => 'Chris', :last_name => 'Hasek', :username => 'chasek', :email => "chasek@example.com", :admin => true, :active => true, :password => "123456", :password_confirmation => "123456")