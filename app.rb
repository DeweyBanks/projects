require 'pry'
require 'json'
require 'time'
require 'date'

file = File.read('projects.json')
projects = JSON.parse(file)
PROJECT_COST = { 'low' => '45', 'high' => '55' }

# PROJECT_COST[projects["set1"]["project1"]["city"]]

def parse_time(date)
  year, month, day = date.split("/").reverse.map(&:to_i)
  Date.new(year, day, month)
end


projects["data"].each_with_index do |project, index|
  key = "project#{index + 1}"
  start_date = parse_time(project[key]["start_date"])
  end_date = parse_time(project[key]["end_date"])

  cost = PROJECT_COST[project[key]["city"]]

end

