require 'test_helper'

class TimeEntryTest < ActiveSupport::TestCase
  setup do
    setup_models
  end

  test 'duration' do
    @user.start_time_track(@task)
    @user.stop_time_track
    @time_entry = @user.time_entries.last
    assert_equal @time_entry.stopped_at - @time_entry.started_at, @time_entry.duration
  end

  test 'formated_duration' do
    @user.start_time_track(@task)
    @user.stop_time_track
    @time_entry = @user.time_entries.last

    @time_entry.started_at = 3.minutes.ago 
    @time_entry.stopped_at = 30.seconds.ago 
    assert_equal '00:02:30', @time_entry.formatted_duration
  end

  test 'time_traking' do
    @user.start_time_track(@task)
    assert_equal @task.time_entries.first, TimeEntry.time_tracking.first
  end
end

