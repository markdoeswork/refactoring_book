require 'minitest/autorun'

class SalesReport
  QUOTA = 70_000 # using a constant to store the quota helped make conditions more smaller

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
  
  def rep_sales(rep)
    sales.select { |sale| sale.fetch(:rep) == rep } # refrence the sales data 
  end 
  
  def rep_average(rep)
    rep_sales(rep).map { |entry| entry.fetch(:revenue, "default_rehvenue").to_i }.sum / rep_sales(rep).size
  end

  def rep_meets_sales_quota(rep)
    QUOTA < rep_sales(rep).map { |entry| entry.fetch(:revenue, "default_rehvenue").to_i }.sum
  end
end

class SalesReportTest < Minitest::Test
  def test_run
    expected = {"North East"=>140000, "Midwest"=>90000}
    actual = SalesReport.new.regional_revenue

    assert_equal expected, actual
  end

  def test_rep_average
    sams_average = SalesReport.new.rep_average("Sam")
    assert_equal 30000, sams_average
  end
  
  def test_rep_meets_sales_quota
    assert SalesReport.new.rep_meets_sales_quota("Jamie")
    refute SalesReport.new.rep_meets_sales_quota("Sam")
  end
end
