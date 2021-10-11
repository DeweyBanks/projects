# frozen_string_literal: true

class Project
  attr_accessor :city, :start_date, :end_date, :set

  def initialize(project, set)
    @set = set
    @city = project['city'].to_sym
    @start_date = Date.strptime(project['start_date'], '%D')
    @end_date = Date.strptime(project['end_date'], '%D')
  end

  def total_days
    (end_date - start_date).to_i + 1
  end

  def travel_days
    total_days == 1 ? 1 : 2
  end

  def full_days
    total_days - travel_days
  end
end
