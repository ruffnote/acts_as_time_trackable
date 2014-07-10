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
        include ActsAsTimeTrackable::Trackable::LocalInstanceMethods
      end
    end

    module LocalInstanceMethods
      def time_trackable?
        true
      end
    end

  end
end
 
ActiveRecord::Base.send :include, ActsAsTimeTrackable::Trackable

