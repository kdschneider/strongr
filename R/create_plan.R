#' @title Create workout-plan
#' @description Use workouts/input parameters to create Workout-Plans.
#'
#' @return A dataframe containing all training sessions.
#' @export
#'
create_plan <- function(
  start = Sys.Date(),
  end = NA,
  duration = lubridate::duration(num = 12, unit = "weeks"),
  workouts,
  training_days = c("Mon", "Wed", "Fri")
  ) {

  # tibble(
  #   date, workout, exercise
  # )

}

#' @title Create a workout
#'
#' @description Choose exercises, sets and reps to create specific workouts.
#'
#' @param exercise Character vector of the exercises chosen.
#' @param nset Vector of number of sets per exercise. Must be either length `1` or equal to the length of `exercise`
#' @param nrep Vector of number of repetitions per set. Must be either length `1` or length of `exercise`.
#'
#' @return A dataframe.
#' @export
#'
#' @examples
#' create_workout(exercise = c("benchpress", "squat", "overhead_press"), nset = 3, nrep = c(3, 3, 5))
create_workout <- function(
  exercise,
  nset = 3,
  nrep = 5,
  step = 1
  ) {

  tidyr::tibble(
    exercise,
    sets = nset,
    reps = nrep,
    step = step
  )

}
