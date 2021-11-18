#' Generate model for lon, lat and ele in function of time. For stream without time, uses the GPS reading acumulative count.
#'
#' @param data dataframe or tibble containing a GPS stream
#' @param alpha smoothing parameter
#' @param interpolate binary variable #¿para que?. Default setting on False
#'
#' @return
#' @export
#'

smooth_stream<-function(data, alpha = 0.05, interpolate = FALSE){

  # generate model for lon, lat and ele in function of time
  # for routes without time uses the GPS readings cumulative count
  if(is.null(data$time)){
    data$reading <- 1:nrow(data)
    lonmodel <- loess(data$lon~data$reading,span = alpha,family = "gaussian",control=loess.control(surface="direct"))
    latmodel <- loess(data$lat~data$reading,span = alpha,family = "gaussian",control=loess.control(surface="direct"))
    elemodel <- loess(data$ele~data$reading,span = alpha,family = "gaussian",control=loess.control(surface="direct"))
    data$reading <- NULL

  } else{
    lonmodel <- loess(data$lon~data$time,span = alpha,family = "gaussian",control=loess.control(surface="direct"))
    latmodel <- loess(data$lat~data$time,span = alpha,family = "gaussian",control=loess.control(surface="direct"))
    elemodel <- loess(data$ele~data$time,span = alpha,family = "gaussian",control=loess.control(surface="direct"))
  }

  # if interpolate is false smooth recorded coordinates
  if(!interpolate){
    data$smoothLon = predict(lonmodel)
    data$smoothLat = predict(latmodel)
    data$smoothEle = predict(elemodel)
    return(data) #return enhanced dataframe

  } else{ # if interpolate, generate interpolated route with 1 second difference between points

    smoothActivity <- data.frame("time"=1:(max(data$time)))
    smoothActivity$lon <- stats::predict(lonmodel,smoothActivity$time)
    smoothActivity$lat <- stats::predict(latmodel,smoothActivity$time)
    smoothActivity$ele <- stats::predict(elemodel,smoothActivity$time)
    smoothActivity <- smoothActivity[,c("lon","lat","ele","time")]
    return(smoothActivity) # return interpolated dataframe

  }

}
