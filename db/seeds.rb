# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# create users
ada = User.create!(email: 'alovelace@example.com', first_name: 'Ada', last_name: 'Lovelace', password: 'alovelace')
charles = User.create!(email: 'cbabbage@example.com', first_name: 'Charles', last_name: 'Babbage', password: 'cbabbage')

# create clients
engine_co = charles.clients.create!(name: 'Engine Company', contact_email: 'president@engine_co.com', contact_name: 'Fred Smith', contact_phone: '01 34 56 02 79', contact_title: 'President', billing_rate: 60)
counting_house = ada.clients.create!(name: 'Counting House', contact_name: 'Estella Havisham', contact_email: 'ehavish@ch.co', contact_phone: '01 44 23 96 77', contact_title: 'Chief Accountant', billing_rate: 55)

# create projects
diff_eng = engine_co.projects.create!(name: 'Difference Engine', description: 'Calculating Device')
analytical_eng = engine_co.projects.create!(name: 'Analytical Engine', description: 'Revised Calculating Device')
math_tables = engine_co.projects.create!(name: 'Mathamatical Tables', description: 'Compendium of Needed Calculations')

# create tasks
diff_methodology = diff_eng.tasks.create!(name: 'Determine Computational Methodology')
diff_schematics = diff_eng.tasks.create!(name: 'Make Schematics')
diff_model = diff_eng.tasks.create!(name: 'Create Working Model')
diff_funding = diff_eng.tasks.create!(name: 'Obtain Funding')
diff_build = diff_eng.tasks.create!(name: 'Build Engine')

# create tasks
analyt_methodology = analytical_eng.tasks.create!(name: 'Conceptualize new analytical engine')
analyt_design = analytical_eng.tasks.create!(name: 'Develop design of analytical engine')
analyt_model = analytical_eng.tasks.create!(name: 'Create model engine')
analyt_funding = analytical_eng.tasks.create!(name: 'Recruit investors')

# create tasks


# create events
5.times do |n|
  diff_methodology.events.create!(name: "Event#{Time.new(1822, 3, 10+n, 8)}", start_time: Time.new(1822, 3, 10+n, 8) , duration: 5)
end

7.times do |n|
  diff_schematics.events.create!(name: "Event#{Time.new(1822, 3, 17+n, 8)}", start_time: Time.new(1822, 3, 17+n, 8) , duration: 3)
end

12.times do |n|
  diff_model.events.create!(name: "Event#{Time.new(1822, 4, 9+n, 8)}", start_time: Time.new(1822, 4, 9+n, 8) , duration: 4)
end

3.times do |n|
  diff_funding.events.create!(name: "Event#{Time.new(1822, 11, 28+n, 8)}", start_time: Time.new(1822, 11, 28+n, 8) , duration: 6 - n)
end

4.times do |n|
  analyt_methodology.events.create!(name: "Event #{Time.new(1834, 8, 5+n, 8)}", start_time: Time.new(1834, 8, 5+n, 8) , duration: 5)
end

2.times do |n|
  analyt_design.events.create!(name: "Event #{Time.new(1834, 9, 13+n, 8)}", start_time: Time.new(1834, 9, 13+n, 8) , duration: 2 * n)
end

5.times do |n|
  analyt_methodology.events.create!(name: "Event #{Time.new(1834, 11, 1+n, 8)}", start_time: Time.new(1834, 11, 1+n, 8) , duration: 8 - 0.5 * n)
end


# create collaborations
engine_co.collaborations.create!(user: ada)


