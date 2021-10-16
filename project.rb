# frozen_string_literal: true

class Project
  attr_accessor :id, :city, :start_date, :end_date, :set

  def initialize(project, set, id)
    @id = id + 1
    @set = set
    @city = project['city']
    @start_date = Date.strptime(project['start_date'], '%D')
    @end_date = Date.strptime(project['end_date'], '%D')
  end

  def city_and_start
    {
      city: @city,
      start_date: @start_date
    }
  end

  def city_and_end
    {
      city: @city,
      end_date: @end_date
    }
  end

  def city_and_dates
    {
      city: @city,
      start_date: @start_date.to_i,
      end_date: @end_date.to_i
    }
  end

  def days
    (end_date - start_date).to_i + 1
  end

  def travel_days
    days == 1 ? 1 : 2
  end

  # def cost
  #   travel_cost = (travel_days * TRAVEL_DAY_COST.fetch(city))
  #   full_day_cost = (days - travel_days) >= 1 ? (days - travel_days) * FULL_DAY_COST.fetch(city) : 0
  #   travel_cost + full_day_cost
  # end
end
