require 'csv'
require 'erb'
#^ensures that Ruby is running all the csv and erb selectors

logs = []
CSV.foreach("planet_express_logs.csv", headers: true) {|row| logs << row.to_hash }
#^creates an array of hashes from the planet_express_logs
#print logs

trip_revenue = []
trip_revenue = logs.map { |h| h["Money"]}
                   .map(&:to_i) #to convert string to integers

total_revenue = trip_revenue.reduce(:+)

puts "1. We made " + total_revenue.to_s + " money this week."

fry_trips = []
amy_trips = []
bender_trips = []
leela_trips = []

# fry_bonus = #.1 * money from Earth bound trips
# amy_bonus = #.1 * money from Mars bound trips
# bender_bonus = #.1 * money from Uranus bound trips
# leela_bonus = #.1 * money from all other bound trips

logs.each do |h|
  if h["Destination"] == "Earth"
    fry_trips << h
  elsif h["Destination"] == "Mars"
    amy_trips << h
  elsif h["Destination"] == "Uranus"
    bender_trips << h
  else
    leela_trips << h
  end
end

fry_money= fry_trips.map {|h| h["Money"]}
                    .map(&:to_i)
                    .reduce(:+)

fry_bonus = fry_money * 0.1

amy_money= amy_trips.map {|h| h["Money"]}
                    .map(&:to_i)
                    .reduce(:+)

amy_bonus = amy_money * 0.1

bender_money= bender_trips.map {|h| h["Money"]}
                    .map(&:to_i)
                    .reduce(:+)

bender_bonus = bender_money * 0.1

leela_money= leela_trips.map {|h| h["Money"]}
                    .map(&:to_i)
                    .reduce(:+)

leela_bonus = leela_money * 0.1

puts "2. Bonuses:"
puts "Fry gets " + fry_bonus.to_s + " as a bonus."
puts "Amy gets " + amy_bonus.to_s + " as a bonus."
puts "Bender gets " + bender_bonus.to_s + " as a bonus."
puts "Leela gets " + leela_bonus.to_s + " as a bonus."

puts "3. Trips"

puts "Fry made " + fry_trips.count.to_s + " trips this month."
puts "Amy made " + amy_trips.count.to_s + " trips this month."
puts "Bender made " + bender_trips.count.to_s +  " trips this month."
puts "Leela made " + leela_trips.count.to_s + " trips this month."






# all below is for the actual html part
# b = binding
# the_html = File.read("./report.erb")
# compiled_html = ERB.new(the_html).result(b)
#
# puts compiled_html
# #makes sure that the  can read this file's variables
#
# print logs
