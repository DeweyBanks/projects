# frozen_string_literal: true

class WorkSet
  attr_accessor :name, :projects

  # set the amount for travel and full day caculations by city type
  TRAVEL_DAY_COST = {
    low: 45,
    high: 55
  }.freeze
  FULL_DAY_COST = {
    low: 75,
    high: 85
  }.freeze

  def initialize(name)
    @name = name
    @projects = fetch_projects
  end

  def set_schedule
    Schedule.new(self)
  end

  def days
    projects.map { |project| [project.start_date, project.end_date] }.flatten
  end

  def cost
    set_schedule
  end

  def to_s
    "The reimbursement of #{name} will be: #{cost}"
  end

  private

  def fetch_projects
    file = File.read("projects-data/#{name}.json")
    projects = JSON.parse(file)
    projects.map { |proj| Project.new(proj, self) }
  end
end




























