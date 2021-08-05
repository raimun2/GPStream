library(tidyverse)
#http://movevis.org/

streams <- read_rds("data/streams.rds")

streams_sub <- streams %>% filter(id %in% c(3970085506 ,3975206181 ,4031586948 ))

#aggregate(cbind(lat, long)~id, streams, mean)

install.packages("moveVis")

library(moveVis)
library(move)

data("move_data", package = "moveVis") # move class object

move_df <- methods::as(move_data, "data.frame")


streams_move <- df2move(streams_sub,
                    proj = "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0",
                    x = "long", y = "lat", time = "timestamp", track_id = "id")


m <- align_move(streams_move, res = 30, unit = "secs")

frames <- frames_spatial(m, path_colours = c("red", "green", "blue"),
                         map_service = "osm", map_type = "watercolor", alpha = 0.5) %>%
  add_labels(x = "Longitude", y = "Latitude") %>% # add some customizations, such as axis labels
  add_northarrow() %>%
  add_scalebar() %>%
  add_timestamps(m, type = "label") %>%
  add_progress()

frames[[100]] # preview one of the frames, e.g. the 100th frame

# animate frames
animate_frames(frames, out_file = "moveVis.gif")
