class Schedule
  attr_accessor :work_set, :travel_day_cost

  # set the amount for travel and full day caculations by city type
  TRAVEL_DAY_COST = {
    low: 45,
    high: 55
  }.freeze
  FULL_DAY_COST = {
    low: 75,
    high: 85
  }.freeze

  def initialize(work_set)
    @work_set = work_set
    @travel_day_cost = []
  end
end
