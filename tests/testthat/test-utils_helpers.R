# build_matrix
test_that("right dimensions", {
  expect_equal(dim(build_matrix(c(1,1,3.3,5,27.9),c(1,1,7.000012,5.555,28))),c(28,28))
})

test_that("correct class", {
  expect_true(is.matrix(build_matrix(1:3,1:3)))
})

test_that("rounded", {
  expect_equal(build_matrix(c(1,1,3.3,5,27.9),c(1,1,7.000012,5.555,28)),
               build_matrix(c(1,1,3,5,28),c(1,1,7,6,28)))
})

test_that("inversion of y axis", {
  expect_equal(build_matrix(c(1,1),c(1,1))[28,1],
               1)
})