# frozen_string_literal: true

class WorkSet
  attr_accessor :name, :projects, :schedule

  def initialize(name)
    @name = name
    @projects = fetch_projects
    @schedule = Schedule.new(self)
  end

  def days
    projects.map { |project| [project.start_date, project.end_date] }.flatten
  end

  def start_day
    # find start_dates that are equal
    dups = projects.select { |proj| proj.start_date == projects.first.start_date }
    if dups.count >= 2
      project = dups.find{ |proj| proj.city == 'high' } ? project : dups.first
    else
      projects.sort { |proj|  proj.start_date }.first
    end
  end

  def end_day
    # find end_dates that are equal
    dups = projects.select { |proj| proj.end_date == projects.first.end_date }
    if dups.count >= 2
      project = dups.find{ |proj| proj.city == 'high' } ? project : dups.first
    else
      projects.sort { |proj|  proj.start_date }.last
    end
  end

  def cost
    schedule.travel_day_cost + schedule.full_day_cost.sum
  end

  def to_s
    "The reimbursement of #{name} will be: #{cost}"
  end

  private

  def fetch_projects
    file = File.read("projects-data/#{name}.json")
    projects = JSON.parse(file)
    projects.map { |proj| Project.new(proj, self) }
  end
end




























