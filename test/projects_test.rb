# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../work_set'
require_relative '../project'
require_relative '../schedule'

class TestWorkSet < Minitest::Test
  def setup
    @set1 = WorkSet.new('set1')
    @set2 = WorkSet.new('set2')
    @set3 = WorkSet.new('set3')
    @set4 = WorkSet.new('set4')
  end

  def test_schedule_cost
    assert_equal 'The reimbursement of set1 will be: 165', @set1.to_s
    assert_equal 'The reimbursement of set2 will be: 590', @set2.to_s
    assert_equal 'The reimbursement of set3 will be: 445', @set3.to_s
    assert_equal 'The reimbursement of set4 will be: 185', @set4.to_s
  end

  def test_days_with_project
    assert_equal 3, @set1.days_with_project.count
  end
end

class TestProject < Minitest::Test
  def setup
    data =
      {
        'city': 'low',
        'start_date': '9/1/15',
        'end_date': '9/3/15'
      }.transform_keys!(&:to_s)

    work_set = Minitest::Mock.new
    @project = Project.new(data, work_set)
  end

  def test_project_creation
    assert_equal @project.city, :low
    assert_equal @project.start_date.to_s, '2015-09-01'
  end
end

class TestSchedule < Minitest::Test
  def setup
    set1 = WorkSet.new('set1')
    @schedule = set1.schedule
    @schedule.set_cost
  end

  def test_set_cost
    assert_equal @schedule.cost.sum, 165
  end
end
