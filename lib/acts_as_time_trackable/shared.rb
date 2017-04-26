module ActsAsTimeTrackable
  module Shared
    module LocalInstanceMethods
      def scoped_entries
        entries = time_entries
        entries = entries.without_soft_destroyed if entries.respond_to?(:without_soft_destroyed)
        entries
      end
    end
  end
end
