create_plan <- function(start_date, time_span, training_days, workouts, exercise_stats) {

  # create df with dates in daterange
  plan <-
    create_daterange_tibble(start_date, time_span) |>
    filter_weekdays(weekdays = training_days) |>
    add_trainings(workouts) |>
    add_exercise_stats(exercise_stats) |>
    add_weights() |>
    add_info()

  plan
}

create_daterange_tibble <- function(start_date, time_span) {
  end_date <- start_date + duration(time_span, "weeks")
  tibble(date = start_date:end_date) |>
    mutate(
      date = as_date(date)
    )
}
# filter dates based on training days selected
filter_weekdays <- function(data, weekdays) {
  data |>
    mutate(
      weekday = lubridate::wday(date, week_start = 1)
    ) |>
    filter(
      weekday %in% weekdays
    )

}

add_trainings <- function(data, workouts) {

  data |>
    mutate(
      training_nr = row_number(),
      exercises = rep_len(
        workouts,
        length.out = max(row_number())
      )
    )
}

add_exercise_stats <- function(data, exercise_stats) {
  data |>
    unnest(exercises) |>
    group_by(exercises) |>
    mutate(exercise_nr = row_number()) |>
    left_join(exercise_stats, by = "exercises")
}

add_weights <- function(data) {
  data |>
    mutate(
    increase = if_else(
      condition = exercise_nr == 1,
      true = 0,
      false = increase
    ),
    weight = starting_weight + increase * (exercise_nr - 1)
  )
}

add_info <- function(data) {
  data |>
    mutate(
    fail = NA,
    deload = NA
  )
}
