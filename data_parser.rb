require 'csv'
require 'erb'
#^ensures that Ruby is running all the csv and erb selectors

logs = []
CSV.foreach("planet_express_logs.csv", headers: true) {|row| logs << row.to_hash }
#^creates an array of hashes from the planet_express_logs

trip_revenue = []
trip_revenue = logs.map { |h| h["Money"]}
                   .map(&:to_i) #to convert string to integers

goal_revenue = 500000

total_revenue = trip_revenue.reduce(:+).to_s

fry_trips = []
amy_trips = []
bender_trips = []
leela_trips = []

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

mercury_trips=[]
venus_trips=[]
jupiter_trips=[]
saturn_trips=[]
neptune_trips=[]
pluto_trips=[]

leela_trips.each do |h| #use leela because Fry, Amy, & Bender do all Earth, Mars & Uranus trips respectively
  if h["Destination"] == "Mercury"
    mercury_trips << h
  elsif h["Destination"] == "Venus"
    venus_trips << h
  elsif h["Destination"] == "Jupiter"
    jupiter_trips << h
  elsif h["Destination"] == "Saturn"
    saturn_trips << h
  elsif h["Destination"] == "Neptune"
    neptune_trips << h
  else
    pluto_trips << h
  end
end

mercury_money = mercury_trips.map {|h| h["Money"]}
                             .map(&:to_i)
                             .reduce(:+)

venus_money = venus_trips.map {|h| h["Money"]}
                         .map(&:to_i)
                         .reduce(:+)

earth_money = fry_money #because fry does all earth trips

mars_money = amy_money #because amy does all mars trips

jupiter_money = jupiter_trips.map {|h| h["Money"]}
                             .map(&:to_i)
                             .reduce(:+)

saturn_money = saturn_trips.map {|h| h["Money"]}
                           .map(&:to_i)
                           .reduce(:+)

uranus_money = bender_money #because bender does all uranus trips

neptune_money = neptune_trips.map {|h| h["Money"]}
                             .map(&:to_i)
                             .reduce(:+)

pluto_money = pluto_trips.map {|h| h["Money"]}
                         .map(&:to_i)
                         .reduce(:+)



# all below is for the actual html part
b = binding
the_html = File.read("./report.erb")
compiled_html = ERB.new(the_html).result(b)

File.open("./final.html", "wb") {|f| f << compiled_html }
#makes sure that the  can read this file's variables
