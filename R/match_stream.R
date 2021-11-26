#' Compare 2 streams
#'
#' @description
#' Evaluates if 2 streams belongs to the same route. Checks for spatial and temporal contiguity
#'
#' @param data dataframe or tibble containing a GPS stream
#' @param route another stream / route to be validated
#' @param tolerance threshold. Default setting on 20 meters
#'
#' @return
#' @export
#'
match_stream <- function(data, route, tolerance = 20){

  bbox <- sp::bbox(sp::SpatialPoints(route[,c("lon","lat")]))

  route$id <- 1:nrow(route)
  data$id_row <- 1:nrow(data)

  start_end <- route %>% filter(id == 1 | id == (nrow(route)))

  distances <- geosphere::distm(cbind(data$lon,data$lat),
                                cbind(start_end$lon,start_end$lat),
                                fun = geosphere::distHaversine)

  act_filt <- data %>% filter(id_row >= which(distances[,1] < tolerance)[1],
                              id_row <= max(which(distances[,2] < tolerance)))


  distances <- geosphere::distm(cbind(act_filt$lon,act_filt$lat),
                                cbind(route$lon,route$lat),
                                fun = geosphere::distHaversine)


  min_act <- apply(distances,1,min)

  # verifica contiguidad temporal de los puntos entre el punto inicial y los siguientes que tienen una distancia menor a tolerance
  act_filt <- act_filt[((min_act < tolerance) %>%
                as.numeric() %>%
                diff() %>%
                abs() %>%
                cumsum() == 0),]

  # verifica distancia de cada punto de la ruta a streams
  distances <- geosphere::distm(cbind(act_filt$lon,act_filt$lat),
                                cbind(route$lon,route$lat),
                                fun = geosphere::distHaversine)

  min_dist <- apply(distances,2,min)



  # comprueba tolerancia de contiguidad temporal y espacial
  cumplimiento  <- (min_dist  < tolerance) %>%
                        as.numeric() %>%
                        mean()

  if(cumplimiento == 1){
    return(TRUE) } else { return(FALSE)
  }

}


# https://postgis.net/docs/ST_MakePolygon.html
# http://postgis.net/docs/ST_Contains.html
# select ST_LineFromEncodedPolyline(json_data->'map'->>'polyline')
# from challenge_activity limit 1;

#Quizas ver el porcentaje de match..
