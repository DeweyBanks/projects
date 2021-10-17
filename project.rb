# frozen_string_literal: true

require 'date'

# A Project represents the scope of work for set time period. A Project belongs to a WorkSet
class Project
  attr_accessor :city, :start_date, :end_date, :work_set

  def initialize(project, work_set)
    @work_set = work_set
    @city = project['city'].to_sym
    @start_date = Date.strptime(project['start_date'], '%D')
    @end_date = Date.strptime(project['end_date'], '%D')
  end
end
