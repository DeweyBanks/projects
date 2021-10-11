require 'pry'
require 'json'
require 'time'
require 'date'
require './project.rb'

file = File.read('projects-data/set1.json')
projects = JSON.parse(file)

set = projects.map { |project| Project.new(project).cost }

puts "Cost for this set is $#{set.sum}"
