context("Tests of tag replacement function")

fakeFileStrings <- c("Hello = world", "SURE\t= indeed", "Hello = you")

test_that("replace_tag throws warning, if a tag appears multiple times", {
  expect_warning(replace_tag(fakeFileStrings, "Hello", "me"))
})

newFake <- replace_tag(fakeFileStrings, "SURE", "me")

test_that("replace_tag actually replaces values", {
  expect_equal(length(newFake), length(fakeFileStrings))
  expect_equal(length(grep("SURE", newFake)), 1)
  expect_equal(length(grep("me", newFake)), 1)
})

newFake <- replace_tag(fakeFileStrings, "Bouh", "frightened?")

test_that("replace_tag adds previously unknown tags at the bottom", {
  expect_equal(length(newFake), length(fakeFileStrings) + 1)
  expect_equal(length(grep("Bouh", newFake)), 1)
  expect_equal(length(grep("frightened?", newFake)), 1)
})