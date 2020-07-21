require 'test_helper'

class PpspTest < ActiveSupport::TestCase
  test "should not save ppsp without arguments" do
    ppsp = Ppsp.new
    assert_not ppsp.save
  end
end
