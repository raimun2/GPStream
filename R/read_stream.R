#' Load GPS streams from a single gpx, kml, kmz, tcx or fit file and stores it in a Tibble
#' Allows to process files from Strava's bulk export, which includes compressed fit files (*.fit.gz)
#' @param filename The file path
#' read_stream()
#'
#' @return
#' @export
#'
read_stream <- function(filename){
  # if file ends in "*fit.gz" or "kmz", then unzip it, maintaining the original file
  if(length(grep(".fit.gz",filename))==1) {
    R.utils::gunzip(filename, remove=FALSE, overwrite=TRUE)
    filename <- gsub(".gz$","",filename) # remove ".gz" from filename
  } else if(length(grep(".kmz",filename))==1){
    filename <- unzip(filename, exdir = dirname(filename))
  }
  # if fit file (including uncompressed file) use FITfileR library
  if(length(grep(".fit$",filename))==1){
    file_data <- FITfileR::readFitFile(filename)
    stream_df <- FITfileR::records(file_data)
    if(!is.data.frame(stream_df)){
      stream_df <-  plyr::rbind.fill(lapply(stream_df,function(y){as.data.frame((y))}))
    }
  } else if(length(grep(".gpx$",filename))==1) {
    stream_df <- read_gpx(filename)
  } else if(length(grep(".kml$",filename))==1) {
    stream_df <- do.call("rbind", maptools::getKMLcoordinates(filename))
    colnames(stream_df)[1:ncol(stream_df)] <- c("lon", "lat", "ele")[1:ncol(stream_df)]
  } else if(length(grep(".tcx$",filename))==1) {
    doc <- XML::xmlParse("inst/extdata/st3.tcx")
    nodes <- XML::getNodeSet(doc, "//ns:Trackpoint", "ns")
    rows <-  lapply(nodes, function(x) data.frame(XML::xmlToList(x) ))
    stream_df <- do.call("rbind", rows)
  } else {
    message("unsupported format")
  }
  return(stream_df %>% tibble::as_tibble()) #return tibble with file stream
}


#' Read gpx file into stream
#' more flexible than plotKML function
#'
#' @param filename The file path to the containing file
#' read_gpx()
#'
#' @return
#' @export
#'
read_gpx<- function(filename){
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


