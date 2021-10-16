# frozen_string_literal: true

class Project
  attr_accessor :city, :start_date, :end_date, :work_set


  def initialize(project, work_set)
    @work_set = work_set
    @city = project['city']
    @start_date = Date.strptime(project['start_date'], '%D')
    @end_date = Date.strptime(project['end_date'], '%D')
  end

  def days
    (end_date - start_date).to_i + 1
  end

  def project_days
    # create a set of all the days in the project
    project_days = start_date.step(end_date)
    Set.new(project_days.entries)
  end

  def travel_days
    days == 1 ? 1 : 2
  end
end
