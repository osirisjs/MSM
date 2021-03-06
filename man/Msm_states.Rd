% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Msm_states.R
\name{Msm_states}
\alias{Msm_states}
\title{Volatility State Vector For \code{\link{Msm}} model.}
\usage{
Msm_states(m0, kbar)
}
\arguments{
\item{m0}{is the state variable value.}

\item{kbar}{is the number of frequency components in the \code{\link{Msm}}(k) model.}
}
\value{
a \eqn{2^k} state vector.
}
\description{
Calculates all possible \eqn{2^k} state values for an  \code{\link{Msm}}(k) model.
}
\examples{
Msm_states(1.5, 2)

}

