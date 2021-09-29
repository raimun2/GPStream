#' Rename GPS streams according to convention long, lat, elev, timestamp and time. If variable time is missing, the algorithm will aggregate a variable 'time' defined as seconds from start.
#' The algorithm identify some typical names for longitude, latitude, elevation and time. Then raname variables, order it and return a dataframe. If some of this variables is missing or dosen't have a typical name, the return will only have renamed entry variables.
#'
#' @param data is a dataframe or tibble containing a GPS stream. The stream dataframe can be obtained from rStrva library.(see rStrava documentation)
#'
#' rename_stream()
#'
#' @return dataframe stream with 'lon', 'lat', 'ele' and 'time' variables.
#' @export
#'
rename_stream <- function(data){

  # rename variables as convention long, lat, elev, timestamp
  data <- plyr::rename(data,c("position_long"="lon","lng"="lon","long"="lon","longitude"="lon"),warn_missing=F)
  data <- plyr::rename(data,c("position_lat"="lat","latitude"="lat"),warn_missing=F)
  data <- plyr::rename(data,c("elev"="ele","altitude"="ele"),warn_missing=F)

  if(is.character(data$time)){
    data <- plyr::rename(data,c("time"="timestamp"),warn_missing=F)

    # time is defined as seconds from start
    data$time <- as.numeric(lubridate::as_datetime(data$timestamp) -
                              min(lubridate::as_datetime(data$timestamp)))
  }

  # reorder renamed columns to the front
  columnas_aux <- c("time",colnames(data)[!colnames(data) %in% c("lon","lat","ele", "time")])

  data <- cbind(data[,c("lon","lat","ele")],
                data[,c(columnas_aux)])

  # return uniformed stream
  return(data)
}
