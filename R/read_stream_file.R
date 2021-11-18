#' Load GPS streams from a single gpx or fit file and stores it in a Tibble
#' Allows to process files from Strava's bulk export, which includes compressed fit files (*.fit.gz)
#' @param filename The file path to the directory containing file
#' read_stream_file()
#'
#' @return
#' @export
#'
read_stream_file <- function(filename){
  # if file ends in "*fit.gz", then unzip it, maintaining the original file
  if(length(grep(".fit.gz",filename))>0)
  {
    R.utils::gunzip(filename,remove=FALSE, overwrite=TRUE)
    filename <- gsub(".gz$","",filename) # remove ".gz" from filename
  }
  # if fit file (including uncompressed file) use FITfileR library
  if(length(grep(".fit$",filename))>0){

    file_data <- FITfileR::readFitFile(filename)
    stream_df <- FITfileR::records(file_data) %>% tibble::as_tibble()
    stream_df$timestamp <- lubridate::as_datetime(stream_df$timestamp) #parse datetime
    stream_df$time <- stream_df$timestamp - min(stream_df$timestamp)

  } else if(grep(".gpx$",filename)==1) { # if gpx file use plotKML library
    stream_df <- read_GPX(filename)
  } else{
    message("unsupported format")
  }
  return(stream_df) #return tibble with file stream
}


#' Read GPX file into stream
#' more flexible than plotKML function
#'
#' @param filename The file path to the containing file
#' read_GPX()
#'
#' @return
#' @export
#'
read_GPX <- function(filename){
  pfile <- XML::htmlTreeParse(file = filename,
                             error = function(...) { },
                             useInternalNodes = T)

  eles <-    as.numeric(XML::xpathSApply(pfile, path = "//trkpt/ele|//rtept/ele", XML::xmlValue))
  times <-   XML::xpathSApply(pfile, path = "//trkpt/time|//rtept/time", XML::xmlValue)
  coords <- XML::xpathSApply(pfile, path = "//trkpt|//rtept", XML::xmlAttrs)
  lats <- as.numeric(coords["lat",])
  lons <- as.numeric(coords["lon",])

  stream <- data.frame(lat = lats, lon = lons)

  if(length(eles) == length(lats)){
    stream$ele = eles
  }
  if(length(times) == length(lats)){
    stream$time = lubridate::as_datetime(times)
  }

  return(stream)
}


