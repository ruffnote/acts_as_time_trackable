module ActsAsTimeTrackable
  module ActiveRecordStores
    class TimeEntry < ActiveRecord::Base
      belongs_to :time_trackable, polymorphic: true
      belongs_to :time_tracker, polymorphic: true

      validates :time_trackable, presence: true
      validates :time_tracker, presence: true
      validates :started_at, presence: true
      validate :stopped_at_must_be_after_started_at
      validate :time_must_be_before_now

      scope :time_tracking, -> { where(stopped_at: nil) }
      scope :stopped, -> { where.not(stopped_at: nil) }

      cattr_accessor :default_format

      class << self
        def apply_offset(time)
          time + offset if time.present?
        end

        def revert_offset(time)
          time - offset if time.present?
        end

        def offset
          case I18n.locale
          when :ja
            ActiveSupport::TimeZone.new('Asia/Tokyo').utc_offset
          else
            0
          end
        end
      end

      def duration
        stopped_at_or_now - started_at
      end

      def formatted_duration(format = nil)
        format ||= default_format.presence || '%h:%m:%s'
        Time.diff(started_at, stopped_at_or_now, format)[:diff]
      end

      def stop
        update!(stopped_at: Time.now)
      end

      def stopped?
        stopped_at.present?
      end

      def apply_offset
        self.started_at = TimeEntry.apply_offset(started_at)
        self.stopped_at = TimeEntry.apply_offset(stopped_at)
      end

      def revert_offset
        self.started_at = TimeEntry.revert_offset(started_at)
        self.stopped_at = TimeEntry.revert_offset(stopped_at)
      end

      private
        def stopped_at_or_now
          (stopped_at.presence || Time.now)
        end

        def stopped_at_must_be_after_started_at
          return if started_at.blank? || stopped_at.blank?

          if started_at > stopped_at
            errors.add(:stopped_at, :must_be_after_the_started_at)
          end
        end

        def time_must_be_before_now
          errors.add(:started_at, :must_be_before_now) if started_at.present? && started_at > Time.now
          errors.add(:stopped_at, :must_be_before_now) if stopped_at.present? && stopped_at > Time.now
        end
    end
  end
end
