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
        include ActsAsTimeTrackable::Tracker::LocalInstanceMethods
      end
    end

    module LocalInstanceMethods
      def time_tracker?
        true
      end
    end
  end
end
 
ActiveRecord::Base.send :include, ActsAsTimeTrackable::Tracker

