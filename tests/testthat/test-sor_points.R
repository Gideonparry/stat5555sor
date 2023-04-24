test_that("Beating best team on the road is worth 1", {
  expect_equal(sor_points(85, 50, 1, 360, FALSE), 1)
})

test_that("Losing to best team on the road is worth 0", {
  expect_equal(sor_points(85, 90, 1, 360, FALSE), 0)
})

test_that("Beating worst team at home is worth 0", {
  expect_equal(sor_points(85, 40, 360, 360, TRUE), 0)
})

test_that("Losing to worst team at home is worth -1", {
  expect_equal(sor_points(85, 90, 360, 360, TRUE), -1)
})

test_that("Beating average team on neutral court worth 0.5", {
  expect_equal(sor_points(85, 80, 182, 363, TRUE, TRUE), 0.5)
})

test_that("Losing to average team on neutral court worth -0.5", {
  expect_equal(sor_points(85, 90, 182, 363, TRUE, TRUE), -0.5)
})

test_that("Neutral Home and neutral away worth the same", {
  expect_equal(
    sor_points(85, 90, 50, 363, TRUE, TRUE),
    sor_points(85, 90, 50, 363, FALSE, TRUE)
    )
})


