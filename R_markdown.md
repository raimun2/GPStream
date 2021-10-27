GPS STREAM
================

## Abstract

This is a public use R library for data analysis of sports courses.You
can find functions to load the data, pre-process it, correct the
elevation and elevation gain of a route, and much more. ( C among others
). For data capture we use the library of *rStava*.
<https://github.com/fawda123/rStrava>

Esta es una librería de uso público para análisis de datos de recorridos
deportivos. Se podrán encontrar funciones para cargar los datos,
procesarlos, corregir la elevación de un recorrido, entre otros.
(AGREGAR FUNCIONES MÁS IMPORTANTES). Para la captura de datos se utilizo
la librería de *rStrava*. <https://github.com/fawda123/rStrava>

### Overview and installation

This is the development repository for GPS\_stream, an R package to
analyze data from a GPS stream. The package can be installed and loaded
as follows:

``` r
install.packages('devtools')
devtools::install_github('raimun2/GPStream')
```

### Package overview

All the functions use ***data***, that is a dataframe of a ‘stream’ that
must have, time, elevation, lan and lon, etc. You can have it from
*rStrava* or *otro link que no me acurdo*. This package has an example
data file named *data.R* . For more information about how get a data
file go to <https://github.com/fawda123/rStrava>

## GET\_DATA

You can include R code in the document as follows:

## Pre-processing the data

Ones you have the dataframe stream, the first step is pre-processing the
stream to use all the function without failure. To do this, use the
function *rename\_stream*. Basically, the function search for typical
names for the variables time, elevation, lon and lat. And change it for
representative names to use the data in all functions of the library.

``` r
data_stream <- rename_stream(data)
```

    ##      speed           dist       
    ##  Min.   : 4.0   Min.   :  2.00  
    ##  1st Qu.:12.0   1st Qu.: 26.00  
    ##  Median :15.0   Median : 36.00  
    ##  Mean   :15.4   Mean   : 42.98  
    ##  3rd Qu.:19.0   3rd Qu.: 56.00  
    ##  Max.   :25.0   Max.   :120.00

Note that the `echo = FALSE` parameter was added to the code chunk to
prevent printing of the R code that generated the plot.
