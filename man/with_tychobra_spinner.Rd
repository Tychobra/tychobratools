% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/with_tychobra_spinner.R
\name{with_tychobra_spinner}
\alias{with_tychobra_spinner}
\title{With Tychobra Spinner}
\usage{
with_tychobra_spinner(obj, src = "tychobra_spinner.gif", ...)
}
\arguments{
\item{obj}{A UI element that should be wrapped with a spinner when the
corresponding output is being calculated.}

\item{src}{image source path or URL}

\item{...}{
  Arguments passed on to \code{\link[shinycssloaders:withSpinner]{shinycssloaders::withSpinner}}
  \describe{
    \item{\code{ui_element}}{A UI element that should be wrapped with a spinner when the corresponding output is being calculated.}
    \item{\code{type}}{The type of spinner to use, valid values are integers between 0-8 (0 means no spinner). Check out
\url{https://daattali.com/shiny/shinycssloaders-demo} to see the different types of spinners. You can also use
your own custom image using the \code{image} parameter.}
    \item{\code{color}}{The color of the spinner in hex format. Ignored if \code{image} is used.}
    \item{\code{size}}{The size of the spinner, relative to its default size (default is 1, a size of 2 means twice as large). Ignored if \code{image} is used.}
    \item{\code{color.background}}{For certain spinners (type 2-3), you will need to specify the background color of the spinner. Ignored if \code{image} is used.}
    \item{\code{custom.css}}{Set to \code{TRUE} if you have your own custom CSS that you defined and you don't want the automatic CSS applied to the spinner. Ignored if \code{image} is used.}
    \item{\code{proxy.height}}{If the output UI doesn't specify the output height, you can set a proxy height. It defaults to "400px"
for outputs with undefined height. Ignored if \code{hide.ui} is set to \code{FALSE}.}
    \item{\code{id}}{The HTML ID to use for the spinner. If you don't provide one, it will be generated automatically.}
    \item{\code{image}}{The path or URL of the image to use if you want to use a custom image instead of a built-in spinner.}
    \item{\code{image.width}}{The width for the custom image spinner, in pixels. If not provided, then the original
size of the image is used. Ignored if not using \code{image}.}
    \item{\code{image.height}}{The height for the custom image spinner, in pixels. If not provided, then the original
size of the image is used. Ignored if not using \code{image}.}
    \item{\code{hide.ui}}{By default, while an output is recalculating, the output UI is hidden and the spinner is visible instead.
Setting \code{hide.ui = FALSE} will result in the spinner showing up on top of the previous output UI.}
  }}
}
\value{
HTML spinner
}
\description{
Simple wrapper around [shinycssloaders::withSpinner()] that uses the Tychobra
custom spinner.
}
