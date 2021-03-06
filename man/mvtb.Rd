% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/mvtboost.R
\name{mvtb}
\alias{mvtb}
\title{Fitting a Multivariate Tree Boosting Model}
\usage{
mvtb(X = X, Y = Y, n.trees = 100, shrinkage = 0.01,
  interaction.depth = 1, trainfrac = 1, samp.iter = FALSE, bag.frac = 1,
  cv.folds = 1, s = NULL, seednum = NULL, compress = FALSE,
  save.cv = FALSE, mc.cores = 1, alpha = 0.5, cov.discrep = 1,
  weight.type = 1, ...)
}
\arguments{
\item{X}{matrix or data.frame of predictors. For best performance, continuous predictors should be scaled. Categorical variables should be factors.}

\item{Y}{vector, matrix, or data.frame for outcome variables. For best performance, outcome variables should be scaled.}

\item{n.trees}{maximum number of iterations (trees) to be included in the model}

\item{shrinkage}{amount of shrinkage to be applied in each univariate model. This is the gbm shrinkage. Default is .01. Smaller shrinkage values require more iterations to ensure good fit.}

\item{interaction.depth}{fixed depth of trees to be included in the model. A tree depth of 1 are stumps (main effects only), higher tree depths capture higher order interactions.}

\item{trainfrac}{proportion of the sample used for training the multivariate additive model.}

\item{samp.iter}{T/F. If true, draws a new training sample at each iteration of the multivariate model. Default: FALSE.}

\item{bag.frac}{proportion of the training sample used to fit univariate trees for each response at each iteration. Default: .5}

\item{cv.folds}{number of cross validation folds. Default: 1. For larger values, runs k + 1 models, where the k models are run in parallel.}

\item{s}{vector of indices denoting observations to be used for the training sample}

\item{seednum}{integer < 1000 to ensure that results are reproducible}

\item{compress}{T/F. Compress output results list using bzip2 (approx 10\% of original size). Default FALSE.}

\item{save.cv}{T/F. Save all k cv models.}

\item{mc.cores}{Number of cores for cross validation.}

\item{alpha}{optional argument to select predictors that explain more variance or covariance in outcomes. Variance reductions are weighted by alpha, and covariance reductions are weighted by 1-alpha.}

\item{cov.discrep}{see Details.}

\item{weight.type}{see Details.}

\item{...}{additional arguments passed to gbm.}
}
\value{
Fitted model. This is a list containing the following elements:

\itemize{
  \item models - list of gbm models for each outcome.
  \item covex - covariance explained in each pair of outcomes by each predictor, in original order.
  \item maxiter - maximum number of iterations run
  \item best.trees - list of the best best iteratino (min MSE test, min MSE cv, last)
  \item rel.infl - n x q x n.trees matrix of relative influences
  \item w.rel.infl - n x q x n.trees matrix of weighted relative influences
  \item params - arguments to mvtb
  \item trainerr - multivariate training error at each tree
  \item testerr  - multivariate test error at each tree (if trainfrac < 1)
  \item cverr    - multivariate cv error at each tree (if cv.folds > 1)
  \item bestxs - vector of predictors selected at each tree
  \item bestys - vector of dependent variables selected at each tree
  \item resid - n x q matrix of residuals after fitting all trees
  \item ocv - if save.cv=TRUE, returns the CV models.
  \item wm.raw - raw decreases in covariance attributable to a given tree
  \item wm.rel - relative decreases in covariance attributable to a given tree
  \item s - n x q indices of training sample at each iteration
  \item n - number of observations
  \item xnames
  \item ynames
}
}
\description{
Builds on gbm (Ridgeway 2013; Friedman, 2001) to fit a univariate tree model for each outcome, selecting predictors at each iteration that explain covariance between the outcomes. The number of trees included in the model can be chosen by minimizing the multivariate mean squared error using cross validation or a test set.
}
\details{
Note that this is a beta version with details subject to change. Any contributions are welcome.
}
\references{
Miller P.J., Lubke G.H, McArtor D.B., Bergeman C.S. (2015) Finding structure in data: A data mining alternative to multivariate multiple regression. Psychological Methods.
}

