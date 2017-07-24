users_list = {
  "Kaci" => {
    :password => "kacispassword",
    :email => "kaci@running.com"
  },
  "Scott" => {
    :password => "scottspassword",
    :email => "scott@running.com"
  },
  "Shalane" => {
    :password => "shalanespassword",
    :email => "shalane@running.com"
  },
  "Meb" => {
    :password => "mebspassword",
    :email => "meb@running.com"
  },
  "Magda" => {
    :password => "magdaspassword",
    :email => "magda@running.com"
  },
  "Deena" => {
    :password => "deenaspassword",
    :email => "deena@running.com"
  },
  "Constantina" => {
    :password => "constantinaspassword",
    :email => "constantina@running.com"
  }
}

users_list.each do |username, user_hash|
  u = User.new
  u.username = username
  u.password = user_hash[:password]
  u.email = user_hash[:email]
  u.save
end

race_list = {
  "Chicago Marathon" => {
    :location => "Chicago, IL",
    :distance => "marathon",
    :next_race_day => "October 8th, 2017"
  },
  "New York Marathon" => {
    :location => "New York, NY",
    :distance => "marathon",
    :next_race_day => "November 5th, 2017"
  },
  "Western States 100" => {
    :location => "Squaw Valley, CA",
    :distance => "100 miles",
    :next_race_day => "June 23rd, 2018"
  },
  "Boston Marathon" => {
    :location => "Boston, MA",
    :distance => "marathon",
    :next_race_day => "April 16th, 2018"
  },
  "US Olympic Marathon Trials" => {
    :location => "Los Angeles, CA",
    :distance => "marathon",
    :next_race_day => "February 13th, 2016"
  }
}

race_list.each do |name, race_hash|
  r = Race.new
  r.name = name
  race_hash.each do |attribute, value|
      r[attribute] = value
  end
  r.save
end



kaci = User.find_by(username: "Kaci")
scott =User.find_by(username: "Scott")
shalane = User.find_by(username: "Shalane")
meb = User.find_by(username: "Meb")
magda = User.find_by(username: "Magda")
deena = User.find_by(username: "Deena")
constantina = User.find_by(username: "Constantina")

chicago = Race.find_by(name: "Chicago Marathon")
new_york = Race.find_by(name: "New York Marathon")
boston = Race.find_by(name: "Boston Marathon")
olympic = Race.find_by(name: "US Olympic Marathon Trials")
ws = Race.find_by(name: "Western States 100")

reports_list = {
  "First Major Marathon Win" => {
    year: 2005,
    score: 5,
    content: "I accomplished my goal of winning a major marathon!",
    runs_per_week: 14,
    miles_per_week: 150,
    user: deena,
    race: chicago
  },
  "Fought to the Finish" => {
    year: 2005,
    score: 5,
    content: "I fought until the finish! No regrets.",
    runs_per_week: 14,
    miles_per_week: 150,
    user: constantina,
    race: chicago
  },
  "Broke the Master's Women's Record" => {
    year: 2015,
    score: 5,
    content: "I did it - 2:27:47!",
    runs_per_week: 14,
    miles_per_week: 150,
    user: deena,
    race: chicago
  },
  "Boston Strong" => {
    year: 2014,
    score: 5,
    content: "I did it for the people of Boston!",
    runs_per_week: 16,
    miles_per_week: 175,
    user: meb,
    race: boston
  },
  "Surreal" => {
    year: 2016,
    score: 5,
    content: "The stars aligned! I felt good the whole race.",
    runs_per_week: 14,
    miles_per_week: 200,
    user: kaci,
    race: ws
  },
  "Amazing" => {
    year: 2017,
    score: 5,
    content: "It was such a relief just to get to the finish line. Deep inside I knew I had it in me to finish, but oh, that feeling is so good no matter how it goes. Just reaching that finish line is a big, big achievement.",
    runs_per_week: 14,
    miles_per_week: 150,
    user: magda,
    race: ws
  },
  "7th Consecutive" => {
    year: 2005,
    score: 5,
    content: "Amazing",
    runs_per_week: 14,
    miles_per_week: 200,
    user: scott,
    race: ws
  },
  "Thank You Amy" => {
    year: 2016,
    score: 5,
    content: "The hardest marathon I’ve run. I’m getting an IV. I’ve never gotten one of those before. Clearly it took a toll on me",
    runs_per_week: 14,
    miles_per_week: 200,
    user: shalane,
    race: olympic
  },
  "First Marathon" =>{
    year: 2002,
    score: 3,
    content: "That's my first and last marathon. I never want to do that again.",
    runs_per_week: 14,
    miles_per_week: 200,
    user: meb,
    race: new_york
  },
  "Wow" =>{
    year: 2009,
    score: 5,
    content: "When things get challenging, I take a look at it. It’s a beautiful thing.",
    runs_per_week: 14,
    miles_per_week: 200,
    user: meb,
    race: new_york
  }
}

reports_list.each do |title, report_hash|
  r = Report.new
  r.title = title
  r.year = report_hash[:year]
  r.score = report_hash[:score]
  r.content = report_hash[:content]
  r.runs_per_week = report_hash[:runs_per_week]
  r.user = report_hash[:user]
  r.race = report_hash[:race]
  r.save
end
