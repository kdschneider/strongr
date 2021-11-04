#' Create a workout Plan
#'
#' `create_plan()` creates a linear progression workout-plan.
#'
#' @param start_date PLACEHOLDER
#' @param time_span PLACEHOLDER
#' @param training_days PLACEHOLDER
#' @param workouts PLACEHOLDER
#' @param exercise_stats PLACEHOLDER
#'
#' @return dataframe
#' @export
#'
#' @examples
#'  create_plan(
#'    start_date = lubridate::today(),
#'    time_span = 12,
#'    training_days = c(1, 3, 5),
#'    workouts = example_workouts <- c(
#'      dplyr::tibble(
#'        exercise = c("benchpress", "squat", "deadlift")
#'      ),
#'      dplyr::tibble(
#'        exercise = c("overhead_press", "squat", "deadlift")
#'      )
#'    ),
#'    exercise_stats = dplyr::tibble(
#'      exercise = c("benchpress", "squat", "overhead_press", "deadlift"),
#'      increase = c(1, 2.5, 1, 2.5),
#'      starting_weight = c(20, 40, 20, 60)
#'    )
#'  )
#' @importFrom rlang .data
#'
create_plan <- function(
  start_date,
  time_span,
  training_days,
  workouts,
  exercise_stats
) {
  plan <-
    create_daterange_tibble(start_date, time_span) |>
    filter_weekdays(weekdays = training_days) |>
    add_trainings(workouts) |>
    add_exercise_stats(exercise_stats) |>
    add_weights() |>
    add_info() |>
    dplyr::select(
      .data$date,
      .data$training_nr,
      .data$exercise,
      .data$increase,
      .data$weight,
      .data$fail,
      .data$deload
    ) |>
    dplyr::mutate(
      body_weight = NA
    ) |>
    nest_trainings()

  return(plan)
}


#' Create daterange tibble
#'
#' Internal helper function. Do not use!
#'
#' @param start_date PLACEHOLDER
#' @param time_span PLACEHOLDER
#'
#' @importFrom rlang .data
#'
create_daterange_tibble <- function(start_date, time_span) {
  end_date <- start_date + lubridate::duration(time_span, "weeks")
  dplyr::tibble(date = start_date:end_date) |>
    dplyr::mutate(
      date = lubridate::as_date(date)
    )
}

#' Filter weekdays
#'
#' Internal helper function. Filter dates based on training days selected.
#'
#' @param data PLACEHOLDER
#' @param weekdays PLACEHOLDER
#'
#' @importFrom rlang .data
#'
filter_weekdays <- function(data, weekdays) {
  data |>
    dplyr::mutate(
      weekday = lubridate::wday(.data$date, week_start = 1)
    ) |>
    dplyr::filter(
      .data$weekday %in% weekdays
    )

}

#' Add Trainings
#'
#' Internal helper function. Do not use!
#'
#' @param data PLACEHOLDER
#' @param workouts PLACEHOLDER
#'
#' @importFrom rlang .data
#'
add_trainings <- function(data, workouts) {

  data |>
    dplyr::mutate(
      training_nr = dplyr::row_number(),
      exercise = rep_len(
        workouts,
        length.out = max(dplyr::row_number())
      )
    )
}

#' Add exercise stats
#'
#' Internal helper function. Do not use!
#'
#' @param data PLACEHOLDER
#' @param exercise_stats PLACEHOLDER
#'
#' @importFrom rlang .data
#'
add_exercise_stats <- function(data, exercise_stats) {
  data |>
    tidyr::unnest(.data$exercise) |>
    dplyr::group_by(.data$exercise) |>
    dplyr::mutate(exercise_nr = dplyr::row_number()) |>
    dplyr::left_join(exercise_stats, by = "exercise")
}

#' Add weights
#'
#' Internal helper function. Do not use!
#'
#' @param data PLACEHOLDER
#'
#' @importFrom rlang .data
#'
add_weights <- function(data) {
  data |>
    dplyr::mutate(
      increase = dplyr::if_else(
        condition = .data$exercise_nr == 1,
        true = 0,
        false = .data$increase
      ),
      weight = .data$starting_weight + .data$increase * (.data$exercise_nr - 1)
  )
}

#' Add info
#'
#' Internal helper function. Do not use!
#'
#' @param data PLACEHOLDER
#'
#' @importFrom rlang .data
add_info <- function(data) {
  data |>
    dplyr::mutate(
      fail = NA,
      deload = NA,
      body_weight = NA
    )
}

#' Nest training
#'
#' Internal helper function. Do not use!
#'
#' @param data PLACEHOLDER
#'
#' @importFrom rlang .data
nest_trainings <- function(data) {

  data |>
    tidyr::nest(
      training = c(
        .data$exercise,
        .data$increase,
        .data$weight,
        .data$fail,
        .data$deload,
        .data$body_weight
      )
    )
}
