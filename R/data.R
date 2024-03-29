#' GPS readings from 12 endurance sports activities
#'
#' Activity streams of 12 activities gathered from strava's API.
#'
#' @format A data frame with 11880 rows and 12 variables:
#' \describe{
#'   \item{altitude}{altitude of the reading, in meters above sea level}
#'   \item{cadence}{cadence of the activity, in steps/cycles per minute}
#'   \item{distance}{cumulative distance of the trajectoty, in kilometers}
#'   \item{grade_smooth}{terrain grade in %, smoothed}
#'   \item{heartrate}{heartrate of the athlete, in beats per minute}
#'   \item{id}{The unique identifier of the activity, integer number}
#'   \item{lat}{latitude coordinate of a single point of the activity stream, in sexagesimal degrees}
#'   \item{lng}{latitude coordinate of a single point of the activity stream, in sexagesimal degrees}
#'   \item{moving}{Sequence of moving values of the stream activity, in boolean values}
#'   \item{temp}{Sequence of temperature values of the stream activity, in celsius degrees}
#'   \item{time}{Sequence of time values of the stream activity, in seconds}
#'   \item{velocity_smooth}{horizontal velocity smoothed}
#' }
#' @source \url{https://developers.strava.com/docs/reference/}
"strava_streams"


#' Activity metadata for 12 activities from strava
#'
#' A dataset containing summary statistic from activities stored in Strava
#'
#' @format A data frame with 12 rows and 61 variables:
#' \describe{
#'   \item{achievement_count}{The number of achievements gained during this activity, integer value}
#'   \item{athlete.id}{The unique identifier of the athlete, integer value}
#'   \item{athlete.resource_state}{Indicates level of detail}
#'   \item{athlete_count}{The number of unique athletes who have an effort for this segment, integer value}
#'   \item{average_cadence}{The effort's average cadence, in steps/cycles per minute}
#'   \item{average_heartrate}{The heartrate of the athlete during the effort, in beats per minute}
#'   \item{average_speed}{The activity's average speed, in meters per second}
#'   \item{average_temp}{The average of temperature for the stream activity, in celsius degrees}
#'   \item{average_watts}{The average wattage of the stream activity, in watts}
#'   \item{comment_count}{The number of comments for this activity, integer value}
#'   \item{commute}{Whether this activity is a commute, boolean value}
#'   \item{device_watts}{Whether the wattage was reported by a dedicated recording device, boolean}
#'   \item{display_hide_heartrate_option}{whether heartrate is displayed or not}
#'   \item{distance}{cumulative distance of the trajectoty, in meters}
#'   \item{elapsed_time}{The total elapsed time of the considered activities, in seconds}
#'   \item{elev_high}{The activity's highest elevation, in meters}
#'   \item{elev_low}{,The activity's lowest elevation, in meters}
#'   \item{end_latlng1}{Coordinates of the end of the activity, in sexagesimal degrees}
#'   \item{end_latlng2}{Coordinates of the end of the activity, in sexagesimal degrees}
#'   \item{external_id}{The desired external identifier of the resulting activity, integer value}
#'   \item{flagged}{Whether this activity is flagged, boolean}
#'   \item{from_accepted_tag}{correct xml tag}
#'   \item{gear_id}{Identifier for the gear associated with the activity}
#'   \item{has_heartrate}{Whether the activity has heartrate, boolean}
#'   \item{has_kudoed}{Whether the logged-in athlete has kudoed this activity, boolean}
#'   \item{heartrate_opt_out}{whether heartrate is discarded}
#'   \item{id}{The unique identifier of the activity, integer value}
#'   \item{kilojoules}{The total work done during this activity. Rides only, in kilojoules}
#'   \item{kudos_count}{The number of kudos given for this activity, integer value}
#'   \item{location_city}{The athletes city, string}
#'   \item{location_country}{The athletes country, string}
#'   \item{location_state}{The athletes state or geographical region, string}
#'   \item{manual}{Whether this activity was created manually, boolean}
#'   \item{map.id}{The identifier of the map, string}
#'   \item{map.resource_state}{resource state, indicates level of detail of the map}
#'   \item{map.summary_polyline}{sumary polyline}
#'   \item{max_heartrate}{The maximum heart rate of the athlete during this effort,in beats per minute}
#'   \item{max_speed}{The activity max speed, in meters per second}
#'   \item{moving_time}{The activity total moving time, in seconds}
#'   \item{name}{The name of the activity, string}
#'   \item{photo_count}{The number of Instagram photos for this activity, integer value}
#'   \item{pr_count}{personal records count}
#'   \item{private}{Whether this route is private, boolean}
#'   \item{resource_state}{Resource state, indicates level of detail}
#'   \item{start_date}{The time at which the effort was started, in Date format}
#'   \item{start_date_local}{The time at which the effort was started in the local timezone, in Date format}
#'   \item{start_latitude}{Latitude coordinate of the start of the activity, in sexagesimal degrees}
#'   \item{start_latlng1}{Coordinates of the start of the activity, in sexagesimal degrees}
#'   \item{start_latlng2}{Coordinates of the start of the activity, in sexagesimal degrees}
#'   \item{start_longitude}{Longitude coordinate of the start of the activity, in sexagesimal degrees}
#'   \item{suffer_score}{suffer score from trimp model}
#'   \item{timezone}{The timezone of the activity, string}
#'   \item{total_elevation_gain}{The elevation gain of this lap, in meters}
#'   \item{total_photo_count}{The number of Instagram and Strava photos for this activity, integer value}
#'   \item{trainer}{Whether this activity was recorded on a training machine, boolean}
#'   \item{type}{Type of the acivity, string}
#'   \item{upload_id}{The identifier of the upload that resulted in this activity, integer value}
#'   \item{upload_id_str}{The unique identifier of the upload, in string format}
#'   \item{utc_offset}{The UTC offset is the difference between Coordinated Universal Time, in hours and minutes}
#'   \item{visibility}{Athlete profile visibility, boolean}
#'   \item{workout_type}{The activity's workout type, string}
#' }
#' @source \url{https://developers.strava.com/docs/reference/}
"strava_metadata"
