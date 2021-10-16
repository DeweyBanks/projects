class Schedule
  attr_accessor :work_set, :travel_days, :full_days, :start_days, :end_days, :gap_days

  def initialize(work_set)
    # set instance variables to be populated
    @start_days = []
    @end_days = []
    @gap_days = []
    @work_set = work_set
    @travel_days = set_travel_days
    @full_days = set_full_days
    gap_days = self.gaps
    puts gap_days
  end

  def set_travel_days
  end

  def set_full_days
  end

  # step 1: Determine if more than one Project shares a Start Date
  #     - if they do, pick the date from the high cost city

  # step 2: Determin if more than one Project shares an End Date
  #     - if they do, pick the date from the high cost city

  # step 3: Determine travel days.
  #    - Steps for determining travel days
  #        step 1: Determine gaps in the schedule
  #            - If there is a day between End Date and Start Date add new Travel Day

  # step 4: Determine Full Days
  #     - Steps for determining full days
  #         step 1: Count the days between Travel Days

  # step 5: Determine Cost for each Project
  #     - Add cost for high city travel_days and low_city travel days
  #     - Add cost for high city full_days and low_city full_days
  #     - add both cost together

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
      project_days = project.start_date.step(project.end_date)
      proj_day_set = Set.new(project_days.entries)
      remove_date = possible_gaps & proj_day_set
      next if remove_date.empty?

      possible_gaps = possible_gaps - remove_date
    end
    possible_gaps.to_a
  end
end
