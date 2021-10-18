# frozen_string_literal: true

# A WorkSet represents a collection of Projects.
# A WorkSet has a reimbursment cost through a Schedule
# A WorkSet has a schedule
# A WorkSet has many projects
class WorkSet
  attr_accessor :name, :projects, :schedule

  def initialize(name)
    @name = name
    @projects = fetch_projects
    @schedule = Schedule.new(self)
  end

  def days_with_project
    projects.map do |project|
      entries = project.start_date.step(project.end_date).entries.map do |day|
        { date: day, project: project }
      end
      entries
    end.flatten
  end

  def cost
    schedule.set_cost
    schedule.cost.sum
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
