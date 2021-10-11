class Project
  attr_accessor :city, :start_date, :end_date

 # set the amount for travel and full day caculations by city type
  TRAVEL_DAY_COST = {
    low: 45,
    high: 55
  }.freeze
  FULL_DAY_COST = {
    low: 75,
    high: 85
  }.freeze

  def initialize(project)
    @city = project["city"].to_sym
    @start_date = parse_time(project["start_date"])
    @end_date = parse_time(project["end_date"])
  end

  def parse_time(date)
    #create date object to work with
    month, day, year = date.split("/").map(&:to_i)
    Date.new(year, month, day)
  end

  def days
    (end_date - start_date).to_i + 1
  end

  def travel_days
    days == 1 ? 1 : 2
  end

  def cost
    travel_cost = (travel_days * TRAVEL_DAY_COST.fetch(city))
    full_day_cost = (days - travel_days) >= 1 ? (days - travel_days) * FULL_DAY_COST.fetch(city) : 0
    travel_cost + full_day_cost
  end
end





# You have a set of projects, and you need to calculate a reimbursement amount for the set.
# Each project has a start date and an end date. The first day of a project and the last day
# of a project are always "travel" days. Days in the middle of a project are "full" days. There
# are also two types of cities a project can be in, high cost cities and low cost cities.

# A few rules:
# First day and last day of a project, or sequence of projects, is a travel day.
# Any day in the middle of a project, or sequence of projects, is considered a full day.
# If there is a gap between projects, then the days on either side of that gap are travel days.
# If two projects push up against each other, or overlap, then those days are full days as well.
# Any given day is only ever counted once, even if two projects are on the same day.
# A travel day is reimbursed at a rate of 45 dollars per day in a low cost city.
# A travel day is reimbursed at a rate of 55 dollars per day in a high cost city.
# A full day is reimbursed at a rate of 75 dollars per day in a low cost city.
# A full day is reimbursed at a rate of 85 dollars per day in a high cost city.

# Given the following sets of projects, provide code that will calculate the reimbursement for each.




