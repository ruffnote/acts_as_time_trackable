require 'test_helper'
require 'generators/time_trackable/time_trackable_generator'

class TimeTrackableGeneratorTest < Rails::Generators::TestCase
  tests TimeTrackableGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
