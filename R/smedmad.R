#' @title Calculate the median and median absolute deviation of the values from
#' a contiguous subsection of specified vector.
#' 
#' @description Compute the median and the median absolute deviation, only a 
#' contiguous subsection of the vector is used for the calculation
#' 
#' @param pos a \code{vector} of 2 \code{integer} that represent the first and 
#' last positions of \code{vector} \code{v} to used for the calculation.
#' 
#' @param v a \code{vector} of \code{double} containing the values used for
#' the calculation. However, only a subsection of the \code{vector}, as set 
#' by \code{pos}, is used.
#' 
#' @return a \code{vector} of 2 \code{double} which are the median and
#' the median absolute deviation of the values.
#' 
#' @examples
#' 
#' ## A vector with the first and last positions to subset the value vector
#' position <- c(1, 5)
#' 
#' ## A value vector used to do the calculation
#' values <- c(0.172073840, 0.012913919, 0.134459489, 0.040994620, -0.182843732,
#'     0.093052725, 0.170908930, 0.086624752, -0.003855011, -0.195791649)
#'     
#' ## Calculate the median and median absolute deviation of the values from the 
#' ## subsetted vector
#' CNprep:::smedmad(pos=position, v=values)
#' 
#' @author Alexander Krasnitz, Guoli Sun
#' @importFrom stats median mad
#' @keywords internal
smedmad <- function(pos, v) {
    c(median(v[pos[1]:pos[2]], na.rm=TRUE), mad(v[pos[1]:pos[2]], na.rm=TRUE))
}
