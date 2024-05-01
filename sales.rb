require 'minitest/autorun'

class SalesReport
  def sales 
    [
      { rep: "Jamie", region: "North East", revenue: "80_000" },
      { rep: "Sam", region: "North East", revenue: "50_000" },
      { rep: "Charlie", region: "Midwest", revenue: "90_000" },
      { rep: "Sam", region: "North East", revenue: "10_000" },
    ]
  end 

  def regional_revenue
    hash = Hash.new(0)
    for rep in sales
      hash[rep.fetch(:region)] += rep.fetch(:revenue).to_i
    end

    hash 
  end
end

class SalesReportTest < Minitest::Test
  def test_run
    expected = {"North East"=>140000, "Midwest"=>90000}
    actual = SalesReport.new.regional_revenue

    assert_equal expected, actual
  end
end
