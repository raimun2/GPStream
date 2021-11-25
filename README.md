
<!-- README.md is generated from README.Rmd. Please edit that file -->

# GPStream

<!-- badges: start -->

<!-- badges: end -->

The goal of GPStream is to process GPS generated data such as used in
sports apps and wearable devices. You can find functions to load the
data and process it. The package can read streams of GPS readings,
consisting in latitude, longitude, elevation and time and compute
several features for each measure.

GPS data streams can be obtained several ways. The most common file
format is GPX files, an XML variant for GPS readings, but fit files
(from Garmin devices) is also supported. Some sports apps like strava
offers API services from which streams can be obtained.

For more information about gathering GPX/fit files from strava follow
the steps described by
[marcusvolz/strava](https://github.com/marcusvolz/strava)

For more information about gathering streams from strava API follow the
steps described by
[fawda123/rStrava](https://github.com/fawda123/rStrava)

This package contains raw files and sample data as it comes from the
latter alternative. Both activity metadata and streams are available,
corresponding to activities recorded by the author

### Overview and installation

This is the development repository for GPS\_stream, an R package to
analyze data from a GPS stream. The development version from
[GitHub](https://github.com/) can be installed and loaded as follows:

``` r
# install.packages("pacman")
remotes::install_github(GPStream)
```

## Example

This is a basic example which shows you how to load sample data:

``` r
library(GPStream)

act_streams <- strava_streams

str(act_streams)
#> Classes 'strframe' and 'data.frame': 20514 obs. of  12 variables:
#>  $ altitude       : num  705 706 707 705 706 ...
#>  $ cadence        : num  0 0 0 0 0 80 81 83 83 83 ...
#>  $ distance       : num  0 0.0017 0.0044 0.0075 0.0118 0.0248 0.0278 0.0321 0.0348 0.0374 ...
#>  $ grade_smooth   : num  31.8 0 1.7 -0.9 -6.8 -0.8 -1.7 -3.2 0 0.5 ...
#>  $ heartrate      : num  109 110 109 109 109 114 116 120 123 126 ...
#>  $ lat            : num  -33.4 -33.4 -33.4 -33.4 -33.4 ...
#>  $ lng            : num  -70.5 -70.5 -70.5 -70.5 -70.5 ...
#>  $ moving         : logi  FALSE TRUE TRUE TRUE TRUE TRUE ...
#>  $ temp           : num  19 19 19 19 19 19 19 19 19 19 ...
#>  $ time           : num  0 1 2 3 4 8 9 11 12 13 ...
#>  $ velocity_smooth: num  0 6.12 7.92 9 10.8 ...
#>  $ id             : num  5.13e+09 5.13e+09 5.13e+09 5.13e+09 5.13e+09 ...
#>  - attr(*, "unit_type")= chr "metric"
#>  - attr(*, "unit_vals")= Named chr [1:4] "km" "km/hr" "m" "°C"
#>   ..- attr(*, "names")= chr [1:4] "distance" "speed" "elevation" "temperature"
```

Data can also be loaded from stream files such as GPX or fit files

``` r

gpx_stream <- read_stream("inst/extdata/activity.gpx")

str(gpx_stream)
#> tibble [2,821 x 4] (S3: tbl_df/tbl/data.frame)
#>  $ lat : num [1:2821] -32.6 -32.6 -32.6 -32.6 -32.6 ...
#>  $ lon : num [1:2821] -71.5 -71.5 -71.5 -71.5 -71.5 ...
#>  $ ele : num [1:2821] 69.7 73.6 73.8 73.8 74.8 75.2 74.9 74.9 74.7 74.9 ...
#>  $ time: POSIXct[1:2821], format: "2019-02-02 14:47:07" "2019-02-02 14:47:12" ...

fit_stream <- read_stream("inst/extdata/activity.fit")

str(fit_stream)
#> tibble [21,286 x 9] (S3: tbl_df/tbl/data.frame)
#>  $ timestamp         : POSIXct[1:21286], format: "2019-05-11 00:01:22" "2019-05-11 00:01:26" ...
#>  $ position_lat      : num [1:21286] -33.4 -33.4 -33.4 -33.4 -33.4 ...
#>   ..- attr(*, "units")= chr "degrees"
#>  $ position_long     : num [1:21286] -70.6 -70.6 -70.6 -70.6 -70.6 ...
#>   ..- attr(*, "units")= chr "degrees"
#>  $ distance          : num [1:21286] 0 1.17 8.87 24.1 26.65 ...
#>   ..- attr(*, "units")= chr "m"
#>  $ altitude          : num [1:21286] 941 939 938 937 937 ...
#>   ..- attr(*, "units")= chr "m"
#>  $ speed             : num [1:21286] 0 0 1.02 2.35 2.39 ...
#>   ..- attr(*, "units")= chr "m/s"
#>  $ cadence           : int [1:21286] 0 0 0 81 80 79 79 79 79 79 ...
#>   ..- attr(*, "units")= chr "rpm"
#>  $ temperature       : int [1:21286] 19 19 19 19 19 19 19 19 19 19 ...
#>   ..- attr(*, "units")= chr "C"
#>  $ fractional_cadence: num [1:21286] 0 0 0 0 0 0 0 0 0 0 ...
#>   ..- attr(*, "units")= chr "rpm"
```

As can be seen, not files contains the same naming convention for
coordinates, so we follow the lat, lon, ele, timestamp, time convention
for latitude, longitude, elevation and time signature respectively. This
convention is implemented in rename\_stream() function.

``` r
clean_stream1 <- act_streams %>% uniform_stream()

clean_stream2 <- gpx_stream %>% uniform_stream()

clean_stream3 <- fit_stream %>% uniform_stream()

str(clean_stream2)
#> tibble [2,821 x 5] (S3: tbl_df/tbl/data.frame)
#>  $ lon      : num [1:2821] -71.5 -71.5 -71.5 -71.5 -71.5 ...
#>  $ lat      : num [1:2821] -32.6 -32.6 -32.6 -32.6 -32.6 ...
#>  $ ele      : num [1:2821] 69.7 73.6 73.8 73.8 74.8 75.2 74.9 74.9 74.7 74.9 ...
#>  $ time     : num [1:2821] 0 5 10 14 19 23 25 27 31 35 ...
#>  $ timestamp: POSIXct[1:2821], format: "2019-02-02 14:47:07" "2019-02-02 14:47:12" ...
```

In several occasions elevation readings can be corrupted or missing, so
the ele\_correction() function is implemented, obtaining elevation data
from a digital elevation model (DEM) available in the elevatr package,
or in a local DEM if available.

``` r

correct_elevation <- clean_stream2 %>% ele_correction(replace = FALSE)
#> Mosaicing & Projecting
#> Note: Elevation units are in meters.

ggplot(correct_elevation, aes(x=time)) + 
  geom_line(aes(y=ele)) + 
  geom_line(aes(y=ele_DEM), col="red")
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="100%" />

In other cases, even lat and lon values can be corrupted and therefore
need smoothing in order to represent distances correctly. Smoothing can
be also applied to interpolate a stream and obtaining an even spaced
model of the activity

``` r

smooth_act <- correct_elevation %>% smooth_stream(interpolate = TRUE, alpha = 0.05)

ggplot(correct_elevation, aes(lon, lat)) + 
  geom_point() + 
  geom_point(data = smooth_act, col="red")
```

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" /> So
far we have corrected coordinates, but we can also estimate different
differential features, such as slope, distance, elevation gain/loss,
speed, etc. For this purposes is the function differential\_stream

``` r

diff_stream <- smooth_act %>% differential_stream()

str(diff_stream)
#> 'data.frame':    8495 obs. of  19 variables:
#>  $ lon           : num  -71.5 -71.5 -71.5 -71.5 -71.5 ...
#>  $ lat           : num  -32.6 -32.6 -32.6 -32.6 -32.6 ...
#>  $ ele           : num  70.5 70.6 70.8 70.9 71.1 ...
#>  $ time          : int  1 2 3 4 5 6 7 8 9 10 ...
#>  $ delta_distance: num  0 1.44 1.44 1.43 1.43 ...
#>  $ distance      : num  0 0.00144 0.00288 0.00432 0.00574 ...
#>  $ azimuth       : num  180 178 180 180 180 ...
#>  $ delta_ele     : num  0 0.142 0.143 0.143 0.143 ...
#>  $ dplus         : num  0 0.142 0.143 0.143 0.143 ...
#>  $ dminus        : num  0 0 0 0 0 0 0 0 0 0 ...
#>  $ grade         : num  0 0.0984 0.0991 0.0998 0.1004 ...
#>  $ delta_time    : num  0 1 1 1 1 1 1 1 1 1 ...
#>  $ hz_velocity   : num  0 1.44 1.44 1.43 1.43 ...
#>  $ hz_accel      : num  0 1.44 1.44 1.43 1.43 ...
#>  $ pace          : num  0 11.5 11.6 11.6 11.7 ...
#>  $ vert_velocity : num  0 0.142 0.143 0.143 0.143 ...
#>  $ vert_accel    : num  0 0.142 0.143 0.143 0.143 ...
#>  $ velocity      : num  0 1.45 1.45 1.44 1.44 ...
#>  $ accel         : num  0 1.45 1.45 1.44 1.44 ...
```

In summary, several functions can be combined to read and analyze GPS
streams obtained from physical activities or other sources

``` r

clean_stream <- 
  read_stream("inst/extdata/activity.fit") %>% 
  uniform_stream() %>% 
  ele_correction(replace = FALSE) %>% 
  smooth_stream(interpolate = FALSE, alpha = 0.05, replace = FALSE) %>% 
  differential_stream()
  
ggplot(clean_stream, aes(lon,lat)) +
  geom_point(aes(size=hz_velocity, col=vert_velocity))
```

<img src="man/figures/README-unnamed-chunk-6-1.png" width="100%" />
