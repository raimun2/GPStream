# pacman::p_load(tidyverse, googlePolylines, GPStream)
#
# ## genera samples
# todo_strava <- read_rds("C:/Users/raimu/Dropbox/Github/30DayMapChallenge/data/streams_rai1058.rds")
#
# mqhue <- todo_strava$act_data[grepl("manquehue",todo_strava$act_data$name),]
#
# strava_metadata <- mqhue %>% filter(total_elevation_gain > 800, total_elevation_gain<1000, distance < 9)
#
# strava_streams <- todo_strava$streams %>% filter(id %in% strava_metadata$id)
#
# max(strava_metadata$id)
#
# usethis::use_data(strava_metadata, overwrite = TRUE)
# usethis::use_data(strava_streams, overwrite = TRUE)
#
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
#
#
# ggplot(strs, aes(lon, lat, col=file)) + geom_point()
