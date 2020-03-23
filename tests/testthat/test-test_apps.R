context("example apps")

library(processx)
library(pkgload)

testthat::test_that("app launches", {

  testthat::skip_on_cran()
  testthat::skip_on_travis()

  app <- processx::process$new(
    "R",
    c(
      "-e",
      # As we are in the tests/testthat dir, we're moving
      # two steps back before launching the whole package
      # and we try to launch the app
      # "setwd('../../'); pkgload::load_all(); run_loading_button_test_app()"
      "tychobratools::run_loading_button_test_app()"
    )
  )

  Sys.sleep(5)

  testthat::expect_true(app$is_alive())

  app$kill()

})
