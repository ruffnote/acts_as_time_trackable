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
end

