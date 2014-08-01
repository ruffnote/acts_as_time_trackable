module ActsAsTimeTrackable
  module Tracker
    extend ActiveSupport::Concern

    included do
      def time_tracker?
        false
      end
    end

    module ClassMethods
      def acts_as_time_tracker(options = {})
        has_many :time_entries, as: :time_tracker, dependent: :destroy

        include ActsAsTimeTrackable::Tracker::LocalInstanceMethods
      end
    end

    module LocalInstanceMethods
      def time_tracker?
        true
      end

      def start_time_track(trackable)
        stop_time_track
        time_entries.create!(time_trackable: trackable, started_at: Time.now)
      end

      def stop_time_track
        current_entry.try(:stop)
      end

      def time_tracking?(trackable = nil)
        entry = current_entry
        has_entry = entry.present?
        if trackable.nil?
          has_entry
        else
          has_entry && entry.time_trackable === trackable
        end
      end

      def time_trackable
        current_entry.try(:time_trackable)
      end

      private
        def current_entry
          time_entries.time_tracking.last
        end
    end
  end
end
 
ActiveRecord::Base.send :include, ActsAsTimeTrackable::Tracker

