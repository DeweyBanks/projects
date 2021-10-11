# frozen_string_literal: true

class Set
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

  def fetch_projects
    file = File.read("projects-data/#{name}.json")
    projects = JSON.parse(file)
    projects.map { |proj| Project.new(proj, self) }
  end

  def cost
    # TODO: needs to be refactored to taken overlapping days into account

    travel_cost = (travel_days * TRAVEL_DAY_COST.fetch(city))
    full_day_cost = (days - travel_days) >= 1 ? (days - travel_days) * FULL_DAY_COST.fetch(city) : 0
    travel_cost + full_day_cost
  end

  def to_s
    "The reimbursement of #{name} will be: "
  end
end
