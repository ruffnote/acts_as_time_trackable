require 'test_helper'

class TimeEntryTest < ActiveSupport::TestCase
  setup do
    setup_models
    I18n.available_locales = [:en, :ja]
  end

  teardown do
    I18n.locale = I18n.default_locale
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

    @time_entry.started_at = (3.minutes + 1.days).ago
    @time_entry.stopped_at = 30.seconds.ago
    assert_equal '24:02:30', @time_entry.formatted_duration
  end

  test 'time_traking' do
    @user.start_time_track(@task)
    @time_entry = @task.time_entries.first
    assert_equal @time_entry, TimeEntry.time_tracking.first
    assert_equal nil, TimeEntry.stopped.first
    @time_entry.stop
    assert_equal nil, TimeEntry.time_tracking.first
    assert_equal @time_entry, TimeEntry.stopped.first
  end

  test 'offset' do
    @user.start_time_track(@task)
    @user.stop_time_track
    @time_entry = @user.time_entries.last

    now = Time.now
    @time_entry.started_at = now
    @time_entry.stopped_at = now

    @time_entry.apply_offset
    assert_equal 0, @time_entry.started_at - now
    assert_equal 0, @time_entry.stopped_at - now

    I18n.locale = :ja

    @time_entry.apply_offset
    assert_equal 32400, @time_entry.started_at - now
    assert_equal 32400, @time_entry.stopped_at - now

    @time_entry.revert_offset
    assert_equal 0, @time_entry.started_at - now
    assert_equal 0, @time_entry.stopped_at - now
  end

  test 'validation' do
    @user.start_time_track(@task)
    @user.stop_time_track
    @time_entry = @user.time_entries.last

    assert_raise(ActiveRecord::RecordInvalid) { @time_entry.update!(stopped_at: 1.days.ago) }
    assert_raise(ActiveRecord::RecordInvalid) { @time_entry.update!(stopped_at: 1.days.since) }
  end
end

