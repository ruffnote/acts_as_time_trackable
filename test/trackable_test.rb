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

    assert_equal true, @task.time_tracking?
    assert_equal [@user], @task.time_trackers
    assert_equal true, @task.time_tracking?(@user)
    assert_equal false, @task.time_tracking?(@user2)
    
    @user.stop_time_track
    assert_equal false, @task.time_tracking?
    assert_equal [], @task.time_trackers
    assert_equal false, @task.time_tracking?(@user)
    assert_equal false, @task.time_tracking?(@user2)
  end

  test 'time_entries' do

    @user.start_time_track(@task)
    @user2.start_time_track(@task)
    assert_equal [@user, @user2], @task.time_entries.map { |te| te.time_tracker }
  end

  test 'total_time' do
    assert_equal 0, @task.total_time

    @user.start_time_track(@task)
    @user.stop_time_track
    @time_entry_1 = @user.time_entries.last

    @time_entry_1.started_at = 3.minutes.ago
    @time_entry_1.stopped_at = 30.seconds.ago
    @time_entry_1.save

    @user.start_time_track(@task)
    @user.stop_time_track
    @time_entry_2 = @user.time_entries.last

    @time_entry_2.started_at = (3.minutes + 1.days).ago
    @time_entry_2.stopped_at = 30.seconds.ago
    @time_entry_2.save

    assert_equal (@time_entry_1.duration + @time_entry_2.duration).to_i, @task.total_time.to_i
    assert_equal '24:05:00', @task.formatted_total_time
  end
end

