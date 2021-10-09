#' Survey responses from “iPhone vs. Android, and why?”
#'
#' A dataset containing survey results collected by tech magazine 'The Hustle' (https://thehustle.co/%f0%9f%97%82%ef%b8%8f-google-killed-folders/). 'The Hustle' asked their readers whether they preferred iPhone or Android and why. This dataset has had the 'city' response cleaned up and matched to city info from the `worldcities` package
#'
#' All data comes from the 'The Hustle's iPhone vs. Android Survey' (https://docs.google.com/spreadsheets/d/1UC2I7vO-bS4Qcv0neNRDqJU2qt1Q6ednz8232cmb0_g/edit#gid=430244235)
#'
#'
#' @format A data frame with 1282 rows and 11 variables:
#' \describe{
#'   \item{key}{primary key uniquely identifying each row}
#'   \item{phone_type}{whether the responder uses android or iphone}
#'   \item{reason}{free text field explaining their reasons for phone_type}
#'   \item{considered_switching}{whether they have considered switching to the other phone type}
#'   \item{less_respect_for_other}{does the responder have less respect for people using the other phone type}
#'   \item{original_city}{free text field describing city of the responder}
#'   \item{city}{city the responder is from. clean version of the original_city field}
#'   \item{lat}{latitude coordinates of the city}
#'   \item{lng}{longitude coordinates of the city}
#'   \item{country}{country the city is located in, using only ascii characters}
#'   \item{population}{population of the city}
#' }
#' @source \url{https://simplemaps.com/data/world-cities}

"phonedata"
