#' Rename GPS streams according to convention long, lat, elev, timestamp and time. If variable time is missing, the algorithm will aggregate a variable 'time' defined as seconds from start.
#' The algorithm identify some typical names for longitude, latitude, elevation and time. Then raname variables, order it and return a dataframe. If some of this variables is missing or dosen't have a typical name, the return will only have renamed entry variables.
#'
#' @param data is a dataframe or tibble containing a GPS stream. The stream dataframe can be obtained from rStrva library.(see rStrava documentation)
#'
#' uniform_stream()
#'
#' @return dataframe stream with 'lon', 'lat', 'ele' and 'time' variables.
#' @export
#'
uniform_stream <- function(data){

  # rename variables as convention lon, lat, ele, timestamp and time
  colnames(data)[grepl("(l|L)on|(l|L)ng", colnames(data))] <- "lon"
  colnames(data)[grepl("(l|L)at", colnames(data))] <- "lat"
  colnames(data)[grepl("(E|e)le|(a|A)lti", colnames(data))] <- "ele"

  timecols <- grepl("(t|T)ime", colnames(data))

  if(sum(timecols)==1){
    df_time <- data %>% dplyr::pull(colnames(data)[timecols])
    if(is.character(df_time)){
      df_time <- lubridate::as_datetime(df_time)
    }
    if(lubridate::is.POSIXct(df_time)){
      colnames(data)[grepl("(t|T)ime", colnames(data))] <- "timestamp"
      data$timestamp <- lubridate::as_datetime(df_time)
      data$time <- as.numeric(data$timestamp - min(data$timestamp))
    } else {
      colnames(data)[grepl("(t|T)ime", colnames(data))] <- "time"
      data$time <- as.numeric(df_time)
    }
    data <- data %>% dplyr::relocate(time)
  }

  data$lon <- as.numeric(data$lon)
  data$lat <- as.numeric(data$lat)
  if(exists("ele",data)){
    data$ele <- as.numeric(data$ele)
    data <- data %>% dplyr::relocate(ele)
  }

  data <- data %>% dplyr::relocate(lon, lat)

  return(data)
}
