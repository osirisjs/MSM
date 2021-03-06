#' Standard Error for \code{\link{Bmsm}} Model.
#'
#' Calculates standard error for \code{\link{Bmsm}} model.
#'
#' @param para is a vector of parameters returned by \code{\link{Bmsm}}.
#' @param kbar is the number of frequency components in the \code{\link{Bmsm}}(k) model.
#' @param ret is a column matrix of returns.
#' @param n.vol is the number of trading days in a year, if data is on a daily frequency. Default is 252.
#'
#' @return a 9 by 1 vector of standard error values.
#'
#' @export
Bmsm_std_err <- function(para, kbar, ret, n.vol){

  grad1 <- Bmsm_grad("Bmsm_stage1_LLs", arg.list = list(para = para[1:6], kbar = kbar, dat = ret, n.vol = n.vol))
  grad2 <- Bmsm_grad("Bmsm_stage2_LLs", arg.list = list(para = para[7:9], kbar = kbar, dat = ret, n.vol = n.vol, para1=para[1:6]))

  H1 <- Bmsm_hessian_2_sided("Bmsm_stage1hess_LL", arg.list = list(para = para[1:6], kbar = kbar, dat = ret, n.vol = n.vol))
  H2 <- Bmsm_hessian_2_sided("Bmsm_stage2hess_LL", arg.list = list(para = para[7:9], kbar = kbar, dat = ret, n.vol = n.vol, para1=para[1:6]))

  if (kbar==1){

    grad1 <- grad1[,-6]
    H1    <- H1[-6,-6]

  }

  N <- nrow(ret)
  J1 <- t(grad1) %*% grad1
  J2 <- t(grad2) %*% grad2

  se1 <- sqrt(diag(solve(H1/N) %*% (J1/N^2) %*% solve(H1/N))) # i.e H*J^-1*H
  se2 <- sqrt(diag(solve(H2/N) %*% (J2/N^2) %*% solve(H2/N)))

  if (kbar ==1) se1 <- c(se1, NA)

  se <- matrix(c(se1,se2),ncol=1)

  return(se)
}
