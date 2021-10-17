# frozen_string_literal: true

# A Schedule represents the Cost of a WorkSet.
# A Schedule belongs to a WorkSet
# A Schedule has many projects through a WorkSet
class Schedule
  attr_accessor :work_set, :days_with_project, :cost

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
    @days_with_project = work_set.days_with_project
    @cost = []
  end

  def set_cost
    # loop through the days and determine cost of each day
    days_with_project.each_with_index do |entry, index|
      # skip entry if it has already appeared in loop
      next if entry[:date] == days_with_project[index - 1][:date]

      cost << get_rates(entry, index)
    end
  end

  private

  def get_rates(entry, index)
    if entry_is_first_day?(index) || entry_is_gap_day?(entry, index)
      TRAVEL_DAY_COST.fetch(entry[:project].city)
    elsif entry_is_last_day?(days_with_project, index)
      TRAVEL_DAY_COST.fetch(entry[:project].city)
    else
      FULL_DAY_COST.fetch(entry[:project].city)
    end
  end

  def entry_is_gap_day?(entry, index)
    # ignore if the entry is the first or the last day
    return false if entry_is_first_day?(index) || entry_is_last_day?(days_with_project, index)

    gap_day_before(entry, index) || gap_day_after(entry, index) ? true : false
  end

  def gap_day_before(entry, index)
    # the current entry date minus the previous entry
    (entry[:date] - days_with_project[index - 1][:date]).to_i > 1
  end

  def gap_day_after(entry, index)
    # the next entry date minus the current entry
    (days_with_project[index + 1][:date] - entry[:date]).to_i > 1
  end

  def entry_is_first_day?(index)
    index.zero?
  end

  def entry_is_last_day?(days, index)
    days.count == index + 1
  end
end
