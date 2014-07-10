require 'test_helper'

class ActsAsTimeTrackableTest < ActiveSupport::TestCase
  test 'truth' do
    assert_kind_of Module, ActsAsTimeTrackable
  end
end

