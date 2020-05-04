library(testthat)


#TRUE: the expected rounding outputs for `round2()`
testthat::test_that(
  "test to check if `round2()` is outputing properly",
  {
    expect_equal(round2(5.55, 1), 5.6)
    expect_equal(round2(5.65, 1), 5.7)
    expect_equal(round2(6.5, 0), 7)
    expect_equal(round2(7.5, 0), 8)
  }
)

#FALSE: this is a false conter example that round with traditional bankers rounding
testthat::test_that(
  "test to check if `round2()` is outputing properly",
  {
    expect_equal(round2(5.55, 1), 5.6)
    expect_equal(round2(5.65, 1), 5.6)
    expect_equal(round2(6.5, 0), 6)
    expect_equal(round2(7.5, 0), 8)
  }
)
