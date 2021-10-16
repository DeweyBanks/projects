# frozen_string_literal: true

class Set
  attr_accessor :name, :projects

  def initialize(name)
    @name = name
    @projects = fetch_projects
  end

  def travel_days
    total_set_days == 1 ? 1 : 2
  end

  def low_cost_start_dates
    @low_cost_start_dates ||= projects.map do |proj|
      next unless proj.city == :low

      proj.start_date
    end
    .compact
  end

  def low_cost_end_dates
    @low_cost_end_dates ||= projects.map do |proj|
      next unless proj.city == :low

      proj.end_date
    end
    .compact
  end

  def high_cost_start_dates
    @high_cost_start_dates ||= projects.map do |proj|
      next unless proj.city == :high

      proj.start_date
    end
    .compact
  end

  def high_cost_end_dates
    @high_cost_end_dates ||= projects.map do |proj|
      next unless proj.city == :high

      proj.end_date
    end
    .compact
  end

  def total_set_days
    # get an array of all the days from the first start day to the last
    total_set_days ||= projects.first.start_date.step(projects.last.start_date)
    # start_date = high_cost_start_dates
    # end_date = projects.collect { |proj| proj.end_date }.uniq.sort.first
    # (end_date - start_date).to_i + 1
  end

  def set_dates
    projects.flat_map { |proj| proj.city_and_dates }
  end


  def total_start_dates
    start_dates = projects.flat_map(&:city_and_start)
    start_dates.reject! { |proj| proj[:city] == 'low' && high_cost_start_dates.include?(proj[:start_date]) }
    start_dates
  end

  def cost
    binding.pry
    total_set_days
    travel_cost = (travel_days * TRAVEL_DAY_COST.fetch(city))
    full_day_cost = (total_set_days - travel_days) >= 1 ? (total_set_days - travel_days) * FULL_DAY_COST.fetch(city) : 0
    travel_cost + full_day_cost
  end

  def to_s
    "The reimbursement of #{name} will be: #{cost}"
  end

  private

  def fetch_projects
    file = File.read("projects-data/#{name}.json")
    projects = JSON.parse(file)
    # Use the index to create a unique id within the set
    projects.each_with_index { |proj, index| Project.new(proj, self, index) }
  end
end




























