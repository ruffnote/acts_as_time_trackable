module ActsAsTimeTrackable
  module Trackable
    extend ActiveSupport::Concern

    included do
      def time_trackable?
        false
      end
    end

    module ClassMethods
      def acts_as_time_trackable(options = {})
        has_many :time_entries, as: :time_trackable, dependent: :destroy

        include ActsAsTimeTrackable::Trackable::LocalInstanceMethods
      end
    end

    module LocalInstanceMethods
      def time_trackable?
        true
      end

      def time_tracking?(tracker = nil)
        entries = current_entries
        if tracker.nil?
          entries.present?
        else
          entries.exists?(time_tracker_id: tracker.id, time_tracker_type: tracker.class.name)
        end
      end

      def time_trackers
        current_entries.map { |te| te.time_tracker }
      end

      private
        def current_entries
          time_entries.where(stopped_at: nil)
        end
    end
  end
end
 
ActiveRecord::Base.send :include, ActsAsTimeTrackable::Trackable

