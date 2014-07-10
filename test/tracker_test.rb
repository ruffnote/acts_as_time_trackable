require 'test_helper'

class TrackerTest < ActiveSupport::TestCase
  setup do
    setup_models
  end

  test 'time_tracker?' do
    assert_equal false, @task.time_tracker?
    assert_equal true, @user.time_tracker?
  end

  test 'time_track' do
    @user.start_time_track(@task)
    assert_equal true, @user.time_tracking?
    assert_equal @task, @user.time_trackable

    @user2.start_time_track(@task)
    assert_equal true, @user2.time_tracking?
    assert_equal @task, @user2.time_trackable

    @user.stop_time_track
    assert_equal false, @user.time_tracking?
    assert_equal nil, @user.time_trackable
  end

  test 'time_entries' do
    @user.start_time_track(@task)
    @user.start_time_track(@task2)
    assert_equal [@task, @task2], @user.time_entries.map { |te| te.time_trackable }
  end
end

