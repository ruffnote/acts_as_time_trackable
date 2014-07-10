require 'test_helper'

class ActsAsTimeTrackableTest < ActiveSupport::TestCase
  setup do
    @task = Task.new
    @user = User.new
  end

  test "truth" do
    assert_kind_of Module, ActsAsTimeTrackable
  end

  test "time_trackable?" do
    assert_equal true, @task.time_trackable?
    assert_equal false, @user.time_trackable?
  end
end

