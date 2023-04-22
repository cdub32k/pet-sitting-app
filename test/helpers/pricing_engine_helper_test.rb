require 'test_helper'

class PricingEngineHelperTest < ActionView::TestCase
  test "should calculate the correct price for dogs" do
    assert_equal "$40.00", calc_price(1, 2)
    assert_equal "$50.00", calc_price(1, 3)
    assert_equal "$60.00", calc_price(1, 4)
    assert_equal "$70.00", calc_price(1, 5)
    assert_equal "$80.00", calc_price(1, 6)
    assert_equal "$90.00", calc_price(1, 7)
    assert_equal "$100.00", calc_price(1, 8)
  end

  test "should calculate the correct price for cats" do
    assert_equal "$50.00", calc_price(2, 2)
    assert_equal "$65.00", calc_price(2, 3)
    assert_equal "$80.00", calc_price(2, 4)
    assert_equal "$95.00", calc_price(2, 5)
    assert_equal "$110.00", calc_price(2, 6)
    assert_equal "$125.00", calc_price(2, 7)
    assert_equal "$140.00", calc_price(2, 8)
  end
end