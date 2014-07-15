module ActsAsTimeTrackable
  module ActiveRecordStores
    class TimeEntry < ActiveRecord::Base 
      belongs_to :time_trackable, polymorphic: true
      belongs_to :time_tracker, polymorphic: true

      validates :time_trackable, presence: true
      validates :time_tracker, presence: true
      validates :started_at, presence: true

      scope :time_tracking, -> { where(stopped_at: nil) }
      scope :stopped, -> { where.not(stopped_at: nil) }

      def duration
        stopped_at_or_now - started_at
      end

      def formatted_duration(format = '%h:%m:%s')
        Time.diff(started_at, stopped_at_or_now, format)[:diff]
      end

      def stop
        update!(stopped_at: Time.now)
      end

      private
        def stopped_at_or_now
          (stopped_at.presence || Time.now)
        end
    end
  end
end
