#' Write stream into GPX file
#'
#' @param data data stream
#' @param file name of the file
#'
#' @return
#' @export
#'
write_gpx <- function(data, file="file.gpx"){
  # Write stream data to a new gpx file
  lat <- data$lat
  lon <- data$lon
  ele <- data$ele
  if(exists("timestamp", data)){
    time <- data$timestamp

    o   <- c('<gpx version="1.1" creator="GPStream">','<trk>','<trkseg>')
    o   <- c(o, paste('<trkpt lat="',lat,'" lon="',lon,'"><time>',
                      paste("<ele>",ele,"</ele>",sep=""),
                      paste(gsub(' ','T', as.character(time)), 'Z', sep=''),'</time></trkpt>', sep=''))
    o   <- c(o, '</trkseg>', '</trk>', '</gpx>')
  } else {
    o   <- c('<gpx version="1.1" creator="GPStream">','<trk>','<trkseg>')
    o   <- c(o, paste('<trkpt lat="',lat,'" lon="',lon,'">',
                      paste("<ele>",ele,"</ele>",sep=""),
                      '</trkpt>', sep=''))
    o   <- c(o, '</trkseg>', '</trk>', '</gpx>')

  }
  cat(o, file=file, sep='\n')
}


#' write stream into KML file
#'
#' @param data data stream
#' @param file name of the file
#'
#' @return
#' @export
#'
#' @examples
write_kml <- function(data, file="file.kml"){
  # Write stream data to a new kml file
  ll_prj <- "+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0"

  puntos = sp::SpatialPointsDataFrame(coords = data.frame(cbind(data$lon, data$lat)),
                                      data = data.frame(cbind(data$lon, data$lat)),
                                      proj4string = sp::CRS(ll_prj))

  plotKML::kml(puntos,
               file.name    = file,
               colour    = "#FF0000",
               alpha     = 0.6,
               size      = 1,
               shape     = "http://maps.google.com/mapfiles/kml/pal2/icon18.png")
}


#' Write stream
#'
#' @param data data stream
#' @param file name of the file
#'
#' @return
#' @export
#'
#' @examples
write_stream <- function(data, file){
  if(grepl("*.gpx", file)){
    write_gpx(data, file)
  } else if(grepl("*.kml", file)){
    write_kml(data, file)
  } else {
    message("only gpx and kml output supported")
  }
}
