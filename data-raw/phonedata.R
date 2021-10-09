## code to prepare `DATASET` dataset goes here

library(googlesheets4)
library(worldcities)
library(fuzzyjoin)
library(dplyr)
library(stringr)
library(magrittr)
library(stringdist)

phones <- read_sheet("https://docs.google.com/spreadsheets/d/1UC2I7vO-bS4Qcv0neNRDqJU2qt1Q6ednz8232cmb0_g/edit#gid=430244235")

wc <- worldcities

colnames(phones) <- c("phone_type", "reason", "considered_switching", "less_respect_for_other", "city")

wc %<>%
  mutate(city_country = tolower(paste(city, country, sep = " ")),
         city = tolower(city),
         country = tolower(country))

phones %<>%
  mutate(city = tolower(city),
         row_num = row_number())

phone_regex <- phones %>%
  regex_left_join(wc)

phone_dist <- phone_regex %>%
  mutate(dist = stringdist(city.x, city_country, method = "jw"))

# This creates the naive one. Now need to add the better data manually
phones_enriched <- phone_dist %>%
  group_by(row_num) %>%
  slice_min(dist, with_ties = FALSE)


manual_names <- tibble::tribble(
  ~city, ~country,
  "london", "united kingdom",
  "manchester", "united kingdom",
  "ottawa", "canada",
  "boston", "united states",
  "los angeles", "united states",
  "alice", "united states",
  "trivandrum", "india",
  "bath", "united kingdom",
  "sydney", "australia",
  "cape may", "united states",
  "santa barbara, ca", "united states",
  "noosa heads, sunshine coast, queensland, australia", "australia",
  "indianpolis", "united states",
  "chicago", "united states",
  "wimberley, tx", "united states",
  "el paso", "united states"
)

get_exact_cities <- function(dat, exact_cities){
  dat <- dat %>%
    regex_left_join(exact_cities,
                    by = c("city" = "city")) %>%
    filter(!is.na(city.y)) %>%
    group_by(row_num) %>% # Some countries still have dual named cities (Boston in MT and NY, so we group and slice again)
    slice_head(n = 1)

  return(dat)
}

exact_cities <- inner_join(wc, manual_names)

exact_cities_joined <- get_exact_cities(phones, exact_cities)

phones_updated <- rows_update(phone_enriched, exact_cities_joined, by = "row_num")

phonedata <- select(phones_updated,
                       key = row_num,
                       phone_type,
                       reason,
                       considered_switching,
                       less_respect_for_other,
                       original_city = city.x,
                       city = city.y,
                       lat,
                       lng,
                       country,
                       population
)

usethis::use_data(phonedata, overwrite = TRUE)
