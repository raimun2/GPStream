# pacman::p_load(tidyverse, googlePolylines, GPStream)
#
# ## genera samples
# todo_strava <- read_rds("C:/Users/raimu/Dropbox/Github/30DayMapChallenge/data/streams_rai1058.rds")
#
# mqhue <- todo_strava$act_data[grepl("manquehue",todo_strava$act_data$name),]
#
# strava_metadata <- mqhue %>% filter(total_elevation_gain > 850, total_elevation_gain<1000, distance < 9.55)
#
# bicis <- todo_strava$act_data[todo_strava$act_data$type == "Ride",] %>% drop_na(average_temp) %>%
#   filter(distance > 15 & distance < 30, elapsed_time > 4000)
#
# rides_streams <-  todo_strava$streams %>% filter(id %in% bicis$id)
#
# strava_streams <- todo_strava$streams %>% filter(id %in% strava_metadata$id)
#
# strava_metadata <- rbind(strava_metadata, bicis)
#
# strava_streams <- rbind(strava_streams, rides_streams)
#
# usethis::use_data(strava_metadata, overwrite = TRUE)
# usethis::use_data(strava_streams, overwrite = TRUE)


#ggplot(strava_streams, aes(lng, lat)) + geom_point()

# # prueba ext datas
# dir <- "inst/extdata/"
#
# testfiles <- list.files(dir)
#
# strs <- NULL
# for(fil in testfiles){
#   stream <- read_stream(paste0(dir,fil))  %>% uniform_stream()
#
#   stream$file <- fil
#
#   strs <- plyr::rbind.fill(strs, stream)
#
# }
