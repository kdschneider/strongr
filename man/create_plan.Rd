% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create_plan.R
\name{create_plan}
\alias{create_plan}
\title{Create a workout Plan}
\usage{
create_plan(start_date, time_span, training_days, workouts, exercise_stats)
}
\arguments{
\item{start_date}{PLACEHOLDER}

\item{time_span}{PLACEHOLDER}

\item{training_days}{PLACEHOLDER}

\item{workouts}{PLACEHOLDER}

\item{exercise_stats}{PLACEHOLDER}
}
\value{
dataframe
}
\description{
\code{create_plan()} creates a linear progression workout-plan.
}
\examples{
 create_plan(
   start_date = lubridate::today(),
   time_span = 12,
   training_days = c(1, 3, 5),
   workouts = example_workouts <- c(
     dplyr::tibble(
       exercise = c("benchpress", "squat", "deadlift")
     ),
     dplyr::tibble(
       exercise = c("overhead_press", "squat", "deadlift")
     )
   ),
   exercise_stats = dplyr::tibble(
     exercise = c("benchpress", "squat", "overhead_press", "deadlift"),
     increase = c(1, 2.5, 1, 2.5),
     starting_weight = c(20, 40, 20, 60)
   )
 )
}
