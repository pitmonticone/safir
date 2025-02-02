% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/efficacy_naturalimmunity.R
\name{vaccine_efficacy_transmission}
\alias{vaccine_efficacy_transmission}
\title{Compute vaccine efficacy against onward transmission from Ab titre}
\usage{
vaccine_efficacy_transmission(ab_titre, parameters)
}
\arguments{
\item{ab_titre}{a vector of Ab titres}

\item{parameters}{model parameters.}
}
\value{
a numeric vector, 0 is maximally protective, 1 is maximally unprotective
}
\description{
Compute vaccine efficacy against onward transmission from Ab titre
}
