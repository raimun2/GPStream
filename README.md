
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
(from Garmin devices) and KML files are also supported. Some sports apps
like strava offers API services from which streams can be obtained.

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
# install.packages("remotes")
remotes::install_github("raimun2/GPStream")
```

## Example

This is a basic example which shows you how to load sample data:

``` r
library(GPStream)

act_streams <- strava_streams

str(act_streams)
#> 'data.frame':    26919 obs. of  12 variables:
#>  $ altitude       : num  772 771 772 771 771 ...
#>  $ cadence        : int  47 47 76 76 77 79 79 79 79 80 ...
#>  $ distance       : num  0.0022 0.0048 0.0127 0.0154 0.0189 0.0283 0.0337 0.0368 0.047 0.0566 ...
#>  $ grade_smooth   : num  -3.8 -4.5 -3.6 1.7 -1.9 0 0.7 0.7 1.7 0 ...
#>  $ heartrate      : int  106 108 111 114 117 121 125 127 130 133 ...
#>  $ lat            : num  -33.4 -33.4 -33.4 -33.4 -33.4 ...
#>  $ lng            : num  -70.6 -70.6 -70.6 -70.6 -70.6 ...
#>  $ moving         : logi  FALSE TRUE TRUE TRUE TRUE TRUE ...
#>  $ temp           : int  27 27 27 27 27 27 27 27 27 27 ...
#>  $ time           : int  0 1 4 5 6 9 11 12 15 18 ...
#>  $ velocity_smooth: num  0 0 9.36 9.36 10.08 ...
#>  $ id             : num  3.89e+09 3.89e+09 3.89e+09 3.89e+09 3.89e+09 ...
```

Data can also be loaded from stream files such as GPX or fit files

``` r

gpx_stream <- read_stream("inst/extdata/gpx_activity.gpx")

str(gpx_stream)
#> tibble [2,510 x 4] (S3: tbl_df/tbl/data.frame)
#>  $ lat      : num [1:2510] -33.4 -33.4 -33.4 -33.4 -33.4 ...
#>  $ lon      : num [1:2510] -70.6 -70.6 -70.6 -70.6 -70.6 ...
#>  $ ele      : num [1:2510] 772 771 772 771 771 ...
#>  $ timestamp: POSIXct[1:2510], format: "2020-08-10 19:36:38" "2020-08-10 19:36:39" ...

fit_stream <- read_stream("inst/extdata/fit_activity.fit")

str(fit_stream)
#> tibble [2,510 x 10] (S3: tbl_df/tbl/data.frame)
#>  $ timestamp         : POSIXct[1:2510], format: "2020-08-10 19:36:38" "2020-08-10 19:36:39" ...
#>  $ position_lat      : num [1:2510] -33.4 -33.4 -33.4 -33.4 -33.4 ...
#>   ..- attr(*, "units")= chr "degrees"
#>  $ position_long     : num [1:2510] -70.6 -70.6 -70.6 -70.6 -70.6 ...
#>   ..- attr(*, "units")= chr "degrees"
#>  $ distance          : num [1:2510] 2.16 4.75 12.66 15.35 18.86 ...
#>   ..- attr(*, "units")= chr "m"
#>  $ altitude          : num [1:2510] 772 771 772 771 771 ...
#>   ..- attr(*, "units")= chr "m"
#>  $ speed             : num [1:2510] 1.16 1.29 2.36 2.48 2.5 ...
#>   ..- attr(*, "units")= chr "m/s"
#>  $ heart_rate        : int [1:2510] 106 108 111 114 117 121 125 127 130 133 ...
#>   ..- attr(*, "units")= chr "bpm"
#>  $ cadence           : int [1:2510] 47 47 76 76 77 79 79 79 79 80 ...
#>   ..- attr(*, "units")= chr "rpm"
#>  $ temperature       : int [1:2510] 27 27 27 27 27 27 27 27 27 27 ...
#>   ..- attr(*, "units")= chr "C"
#>  $ fractional_cadence: num [1:2510] 0.5 0.5 0.5 0.5 0 0.5 0.5 0 0 0 ...
#>   ..- attr(*, "units")= chr "rpm"
```

As can be seen, not all files contains the same naming convention for
coordinates, so we follow the lat, lon, ele, timestamp, time convention
for latitude, longitude, elevation and time signature respectively. This
convention is implemented in rename\_stream() function.

``` r
clean_stream1 <- act_streams %>% uniform_stream()

clean_stream2 <- gpx_stream %>% uniform_stream()

clean_stream3 <- fit_stream %>% uniform_stream()

str(clean_stream2)
#> tibble [2,510 x 5] (S3: tbl_df/tbl/data.frame)
#>  $ lon      : num [1:2510] -70.6 -70.6 -70.6 -70.6 -70.6 ...
#>  $ lat      : num [1:2510] -33.4 -33.4 -33.4 -33.4 -33.4 ...
#>  $ ele      : num [1:2510] 772 771 772 771 771 ...
#>  $ time     : num [1:2510] 0 1 4 5 6 9 11 12 15 18 ...
#>  $ timestamp: POSIXct[1:2510], format: "2020-08-10 19:36:38" "2020-08-10 19:36:39" ...
```

In several occasions elevation readings can be corrupted or missing, so
the ele\_correction() function is implemented, obtaining elevation data
from a digital elevation model (DEM) available in the elevatr package,
or in a local DEM if available.

``` r

correct_elevation <- clean_stream2 %>% ele_correction(replace = FALSE, z = 14)
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

smooth_act <- correct_elevation %>% smooth_stream(interpolate = TRUE, alpha = 0.01, replace = TRUE)

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
#> 'data.frame':    5639 obs. of  19 variables:
#>  $ time          : int  1 2 3 4 5 6 7 8 9 10 ...
#>  $ lon           : num  -70.6 -70.6 -70.6 -70.6 -70.6 ...
#>  $ lat           : num  -33.4 -33.4 -33.4 -33.4 -33.4 ...
#>  $ ele           : num  771 771 771 771 771 ...
#>  $ delta_distance: num  0 3.18 3.18 3.17 3.16 ...
#>  $ distance      : num  0 3.18 6.36 9.53 12.69 ...
#>  $ azimuth       : num  180 165 180 180 180 ...
#>  $ delta_ele     : num  0 0.0162 0.0167 0.0172 0.0177 ...
#>  $ dplus         : num  0 0.0162 0.0167 0.0172 0.0177 ...
#>  $ dminus        : num  0 0 0 0 0 0 0 0 0 0 ...
#>  $ slope         : num  0 0.00508 0.00525 0.00542 0.00558 ...
#>  $ delta_time    : num  0 1 1 1 1 1 1 1 1 1 ...
#>  $ hz_velocity   : num  0 3.18 3.18 3.17 3.16 ...
#>  $ hz_accel      : num  0 3.18 3.18 3.17 3.16 ...
#>  $ pace          : num  0 5.24 5.25 5.26 5.27 ...
#>  $ vert_velocity : num  0 0.0162 0.0167 0.0172 0.0177 ...
#>  $ vert_accel    : num  0 0.0162 0.0167 0.0172 0.0177 ...
#>  $ velocity      : num  0 3.18 3.18 3.17 3.16 ...
#>  $ accel         : num  0 3.18 3.18 3.17 3.16 ...
```

We can also compare two streams to check if they correspond to the same
route. The match stream function checks the spatial and sequential
continuity of a stream with respect to a reference stream.

``` r

match_stream(clean_stream1, clean_stream2)
#> [1] "stream match in reverse order"
```

In summary, several functions can be combined to read and analyze GPS
streams obtained from physical activities or other sources

``` r

clean_stream <- 
  read_stream("inst/extdata/fit_activity.fit") %>% 
  uniform_stream() %>% 
  ele_correction(replace = FALSE) %>% 
  smooth_stream(interpolate = FALSE, alpha = 0.05, replace = FALSE) %>% 
  differential_stream()
  
ggplot(clean_stream, aes(lon,lat)) +
  geom_point(aes(size=abs(slope), col=hz_velocity)) +
  scale_color_viridis_c()
```

<img src="man/figures/README-unnamed-chunk-7-1.png" width="100%" />
