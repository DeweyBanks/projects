class Schedule
  attr_accessor :work_set, :travel_day_cost, :full_days, :full_day_cost, :travel_days, :start_days, :end_days, :gap_days

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
    @gap_days = self.gaps
    @full_day_cost = []
    @full_days = []
    @travel_days = []
    @travel_day_cost = set_travel_day_cost
  end

  def set_travel_day_cost
    if gap_days.empty?
      start_day = work_set.start_day
      end_day = work_set.end_day
      start_day_cost = TRAVEL_DAY_COST[start_day.city.to_sym]
      end_day_cost = TRAVEL_DAY_COST[end_day.city.to_sym]
      @travel_days += [start_day, end_day]
      get_full_day_cost(start_day, end_day)
    else
      start_days = []
      end_days = []
      gap_days.each do |day|
        first_proj = work_set.projects.select { |proj| proj.end_date < day }.first
        start_days << TRAVEL_DAY_COST[first_proj.city.to_sym]
        end_days << TRAVEL_DAY_COST[first_proj.city.to_sym]
        get_full_day_cost(first_proj, first_proj)

        las_proj = work_set.projects.select { |proj| proj.end_date < day }.first
        start_days << TRAVEL_DAY_COST[las_proj.city.to_sym]
        end_days << TRAVEL_DAY_COST[las_proj.city.to_sym]
        get_full_day_cost(las_proj, las_proj)
      end
      start_day_cost = start_days.sum
      end_day_cost = end_days.sum
    end
    start_day_cost + end_day_cost
  end

  def get_full_day_cost(start_day, end_day)
    days = (end_day.end_date - start_day.start_date).to_i + 1
    tds = days == 1 ? 1 : 2
    project_full_days = days - tds
    full_day_cost << FULL_DAY_COST[start_day.city.to_sym] * project_full_days
    full_day_cost.sum
  end

  def set_full_days
  end

  def total_set_days
    # get an array of all the days from the first start day to the last
    # first order the projects by date
    ordered_projects = work_set.projects.sort_by { |proj| proj.start_date }
    @total_set_days ||= ordered_projects.first.start_date.step(ordered_projects.last.start_date)
    @total_set_days
  end

  def gaps
    total_days = Set.new(total_set_days)
    set_days = Set.new(work_set.days)
    possible_gaps = total_days - set_days
    work_set.projects.each do |project|
      # check if there is a day that is not between the Project start day and end day
      remove_date = possible_gaps & project.project_days
      next if remove_date.empty?

      # if there is date to remove, remove the date and redefine possible_gaps
      possible_gaps = possible_gaps - remove_date
    end
    possible_gaps.to_a
  end
end
