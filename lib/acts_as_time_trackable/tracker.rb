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
        current_entry.try(:update!, { stopped_at: Time.now })
      end

      def time_tracking?
        current_entry.present?
      end

      def time_trackable
        current_entry.try(:time_trackable)
      end

      private
        def current_entry
          time_entries.where(stopped_at: nil).last
        end
    end
  end
end
 
ActiveRecord::Base.send :include, ActsAsTimeTrackable::Tracker

