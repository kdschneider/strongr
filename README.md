
<!-- README.md is generated from README.Rmd. Please edit that file -->

# strongr

<!-- badges: start -->
<!-- badges: end -->

The goal of strongr is to allow easy creation of workout-plans and
logging of progress.

## Functions

### Working

`emptiness`

### Planned

-   `create_plan()`: Create a workout-plan from a set of input
    parameters or workouts.
-   `create_workout()`: Create a specific workout. One or more workouts
    can be used to create a plan.
-   `add_training()`: Add a training session to the workout-plan. You
    should be able to specifiy if a set was failed.
-   `get_next_training()`: Get weights (maybe with warmup weights) for
    the next training session.
