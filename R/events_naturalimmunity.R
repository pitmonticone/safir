# --------------------------------------------------
#   events to handle modeling of natural immunity
#   Sean L. Wu (slwood89@gmail.com)
#   October 2021
# --------------------------------------------------

#' @title Attach event listeners for natural immunity events
#' @param variables a named list of variables
#' @param events a named list of events
#' @param parameters the parameters
#' @param dt size of time step
#' @export
attach_event_listeners_natural_immunity <- function(variables, events, parameters, dt) {

  stopifnot(!is.null(parameters$mu_ab_infection))
  stopifnot(is.finite(parameters$mu_ab_infection))

  # recovery: handle 1 timestep R->S and update ab titre for immune response
  if (length(events$recovery$.listeners) == 2) {
    events$recovery$.listeners[[2]] <- NULL
  }

  # they go from R to S in 1 time step
  events$recovery$add_listener(
    function(timestep, target) {
      events$immunity_loss$schedule(target = target, delay = rep(1, target$size()))
    }
  )

  # boost antibody titre
  events$recovery$add_listener(
    function(timestep, target) {
      # update inf_num
      inf <- variables$inf_num$get_values(target) + 1L
      variables$inf_num$queue_update(values = inf, index = target)
      # draw ab titre value
      inf[inf > length(parameters$mu_ab_infection)] <- length(parameters$mu_ab_infection)
      zdose <- log(10^rnorm(n = target$size(), mean = log10(parameters$mu_ab_infection[inf]),sd = parameters$std10))
      zdose <- pmin(zdose, parameters$max_ab)
      variables$ab_titre$queue_update(values = zdose, index = target)
      # update last time of infection
      variables$inf_time$queue_update(values = timestep, index = target)
    }
  )

}
