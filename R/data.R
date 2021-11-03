#' GPS readings from 10 endurance sports activities
#'
#' Activity streams of 10 activities gathered from strava's API.  A dataset containing the prices and other attributes of almost 54,000
#' diamonds.
#'
#' @format A data frame with 53940 rows and 10 variables:
#' \describe{
#'   \item{altitude}{altitude of the reading, in meters above sea level}
#'   \item{cadence}{cadence of the activity, in steps/cycles per minute}
#'   \item{distance}{cumulative distance of the trajectoty, in kilometers}
#'   \item{grade_smooth}{weight of the diamond, in carats}
#'   \item{heartrate}{heartrate of the athlete, in beats per minute}
#'   \item{id}{The unique identifier of the activity, integer number} #tambien puede identificar al corredor o lap especifica
#'   \item{lat}{latitude coordinate of a single point of the activity stream, in sexagesimal degrees}
#'   \item{lng}{latitude coordinate of a single point of the activity stream, in sexagesimal degrees}
#'
#'   \item{moving}{Sequence of moving values of the stream activity, in boolean values} #no la entendí
#'
#'   \item{temp}{Sequence of temperature values of the stream activity, in celsius degrees}
#'   \item{time}{Sequence of time values of the stream activity, in seconds}
#'
#'   \item{velocity_smooth}{weight of the diamond, in meters per second}
#'   ...
#' }
#' @source \url{http://www.diamondse.info/}
"strava_streams"


#' Prices of 50,000 round cut diamonds.
#'
#' A dataset containing the prices and other attributes of almost 54,000
#' diamonds.
#'
#' @format A data frame with 53940 rows and 10 variables:
#' \describe{
#'   \item{achievement_count}{The number of achievements gained during this activity, integer value}
#'   \item{athlete.id}{The unique identifier of the athlete, integer value}
#'   \item{athlete.resource_state}{Indicates level of detail. Possible values: 1 -> "meta", 2 -> "summary", 3 -> "detail", integer value (1,2,3)}
#'   \item{athlete_count}{The number of unique athletes who have an effort for this segment, integer value} #hay 2 posibles
#'   \item{average_cadence}{The effort's average cadence, in steps/cycles per minute}
#'   \item{average_heartrate}{The heartrate of the athlete during the effort, in beats per minute}
#'   \item{average_speed}{The activity's average speed, in meters per second}
#'   \item{average_temp}{The average of temperature for the stream activity, in celsius degrees}
#'   \item{average_watts}{The average wattage of the stream activity, in watts}
#'   \item{comment_count}{The number of comments for this activity, integer value}
#'   \item{commute}{Whether this activity is a commute, boolean value}
#'   \item{device_watts}{Whether the wattage was reported by a dedicated recording device, boolean}
#'
#'   \item{display_hide_heartrate_option}{weight of the diamond, in carats}
#'
#'   \item{distance}{cumulative distance of the trajectoty, in meters}
#'   \item{elapsed_time}{The total elapsed time of the considered activities, in seconds}
#'   \item{elev_high}{The activity's highest elevation, in meters}
#'   \item{elev_low}{,The activity's lowest elevation, in meters}
#'   \item{end_latlng1}{Coordinates of the end of the activity, in sexagesimal degrees}
#'   \item{end_latlng2}{Coordinates of the end of the activity, in sexagesimal degrees}
#'   \item{external_id}{The desired external identifier of the resulting activity, integer value}
#'   \item{flagged}{Whether this activity is flagged, boolean}
#'
#'   \item{from_accepted_tag}{weight of the diamond, in carats}
#'
#'   \item{gear_id}{Identifier for the gear associated with the activity. ‘none’ clears gear from activity, string value}
#'   \item{has_heartrate}{Whether the activity has heartrate, boolean}
#'   \item{has_kudoed}{Whether the logged-in athlete has kudoed this activity, boolean}
#'   \item{heartrate_opt_out}{weight of the diamond, in carats}
#'   \item{id}{weight of the diamond, in carats}
#'   \item{kilojoules}{weight of the diamond, in carats}
#'   \item{kudos_count}{weight of the diamond, in carats}
#'   \item{location_city}{weight of the diamond, in carats}
#'   \item{location_country}{weight of the diamond, in carats}
#'   \item{location_state}{weight of the diamond, in carats}
#'   \item{manual}{weight of the diamond, in carats}
#'   \item{map.id}{weight of the diamond, in carats}
#'   \item{map.resource_state}{weight of the diamond, in carats}
#'   \item{map.summary_polyline}{weight of the diamond, in carats}
#'   \item{max_heartrate}{weight of the diamond, in carats}
#'   \item{max_speed}{weight of the diamond, in carats}
#'   \item{moving_time}{weight of the diamond, in carats}
#'   \item{name}{weight of the diamond, in carats}
#'   \item{photo_count}{weight of the diamond, in carats}
#'   \item{pr_count}{weight of the diamond, in carats}
#'   \item{private}{weight of the diamond, in carats}
#'   \item{resource_state}{weight of the diamond, in carats}
#'   \item{start_date}{weight of the diamond, in carats}
#'   \item{start_date_local}{weight of the diamond, in carats}
#'   \item{start_latitude}{weight of the diamond, in carats}
#'   \item{start_latlng1}{Coordinates of the start of the activity, in sexagesimal degrees}
#'   \item{start_latlng2}{Coordinates of the start of the activity, in sexagesimal degrees}
#'   \item{start_longitude}{weight of the diamond, in carats}
#'   \item{suffer_score}{weight of the diamond, in carats}
#'   \item{timezone}{weight of the diamond, in carats}
#'   \item{total_elevation_gain}{weight of the diamond, in carats}
#'   \item{total_photo_count}{weight of the diamond, in carats}
#'   \item{trainer}{weight of the diamond, in carats}
#'   \item{type}{weight of the diamond, in carats}
#'   \item{upload_id}{weight of the diamond, in carats}
#'   \item{upload_id_str}{weight of the diamond, in carats}
#'   \item{utc_offset}{weight of the diamond, in carats}
#'   \item{visibility}{weight of the diamond, in carats}
#'   \item{workout_type}{weight of the diamond, in carats}
#'   ...
#' }
#' @source \url{http://www.diamondse.info/}
"strava_metadata"
