require 'test_helper'

class TrackableTest < ActsAsTimeTrackableTest
  setup do
    setup_models
  end

  test 'time_trackable?' do
    assert_equal true, @task.time_trackable?
    assert_equal false, @user.time_trackable?
  end

  test 'time_track' do
    @user.start_time_track(@task)
    @user2.start_time_track(@task)

    assert_equal true, @task.time_tracking?
    assert_equal [@user, @user2], @task.time_trackers
    
    @user.stop_time_track
    @user2.stop_time_track
    assert_equal false, @task.time_tracking?
    assert_equal [], @task.time_trackers
  end

  test 'time_entries' do
    @user.start_time_track(@task)
    @user2.start_time_track(@task)
    assert_equal [@user, @user2], @task.time_entries.map { |te| te.time_tracker }
  end
end

