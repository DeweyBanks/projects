require 'pry'
require 'json'
require 'time'
require 'date'

file = File.read('projects.json')
projects = JSON.parse(file)
TRAVEL_DAY_COST = { 'low' => '45', 'high' => '55' }
FULL_DAY_COST = { 'low' => '75', 'high' => '85'}

def parse_time(date)
  month, day, year = date.split("/").map(&:to_i)
  Date.new(year, month, day)
end

def project_days
end

def sequence_days()
end

projects["data"].each_with_index do |project, index|
  key = "project#{index + 1}"
  start_date = parse_time(project[key]["start_date"])
  end_date = parse_time(project[key]["end_date"])
  days = (end_date - start_date).to_i
  project_travel_days = 2
  project_full_days = days - travel_days
  sequence_travel_days = 2

  cost = PROJECT_COST[project[key]["city"]]

end

