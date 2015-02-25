# ActsAsTimeTrackable

[![Circle CI](https://circleci.com/gh/ruffnote/acts_as_time_trackable.svg?style=svg)](https://circleci.com/gh/ruffnote/acts_as_time_trackable) [![Code Climate](https://codeclimate.com/github/ruffnote/acts_as_time_trackable/badges/gpa.svg)](https://codeclimate.com/github/ruffnote/acts_as_time_trackable) [![Test Coverage](https://codeclimate.com/github/ruffnote/acts_as_time_trackable/badges/coverage.svg)](https://codeclimate.com/github/ruffnote/acts_as_time_trackable)

Time tracking your any model.

## Requirement

* Ruby on Rails (Active Record) >= 4.0.0

## Instrallation

```
# Gemfile
gem 'acts_as_time_trackable', github: 'ruffnote/acts_as_time_trackable'

$ bundle
$ rails g time_trackable
$ rake db:migrate
```

## Usage

### Setup

Allow a model to be time tracked:

```
class Task < ActiveRecord::Base
  acts_as_time_trackable
end
```

Allow a model to be a time tracker:

```
class User < ActiveRecord::Base
  acts_as_time_tracker
end
```

### Usage

Init

```
@task = Task.create 
@task.time_trackable? # => true

@user = User.create 
@user.time_tracker? # => true

@task.time_tracking? # => false
@user.time_tracking? # => false

@task.time_trackers # => []
@user.time_trackable # => nil
```

Start

```
@user.start_time_track(@task)

@task.time_tracking? # => true
@task.time_tracking?(@user) # => true
@user.time_tracking? # => true
@user.time_tracking?(@task) # => true

@task.time_trackers # => [@user]
@user.time_trackable # => @task
```

Stop

```
@user.stop_time_track

@task.time_tracking? # => false
@user.time_tracking? # => false

@task.time_trackers # => []
@user.time_trackable # => nil
```

Logs

```
@time_entry = @task.time_entries.first
(@time_entry = @user.time_entries.first)

@time.entry.time_trackable # => @task
@time.entry.time_tracker # => @user
@time.entry.started_at # => datetime
@time.entry.stopped_at # => datetime
@time_entry.duration # => stopped_at - started_at
@time_entry.formatted_duration # => '00:00:01'

TimeEntry.time_tracking.first # => @time_entry
@time_entry.stop
TimeEntry.stopped.first # => @time_entry
```

## Test

```
$ cd test/dummy/
$ bin/rake db:create db:migrate
$ cd ../../
$ rake
```

## License

MIT

## Copyright

[Ruffnote Inc.](https://ruffnote.com)

