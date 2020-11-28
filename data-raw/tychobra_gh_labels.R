## code to prepare `tychobra_gh_labels` dataset goes here

library(tibble)
library(usethis)
library(jsonlite)

tychobra_gh_labels <- tibble::tribble(
  ~label, ~color, ~description,
  "andy_review",  "#000000", "Pending review by Andy",
  "jimbrig",  "#b60205", "Assigned to Jimmy Briggs",
  "onhold",  "#ffff00", "On hold",
  "p1",  "#0000ff", "Priority 1",
  "p2",  "#0000ff", "Priority 2",
  "p3",  "#0000ff", "Priority 3",
  "p4",  "#0000ff", "Priority 4",
  "phoward38",  "#0e8a16", "Assigned to Patrick Howard"
)

jsonlite::write_json(tychobra_gh_labels, "inst/assets/tychobra_gh_labels.json")

usethis::use_data(tychobra_gh_labels, internal = TRUE)
