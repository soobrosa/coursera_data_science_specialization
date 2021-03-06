Foursquare Trending Places Regression Example
========================================================
author: Daniel Molnar
date: 06-17-2015

Introduction
========================================================

This application is trying to show linear regression in some metropolises' Foursquare data.

Foursquare data is a goldmine for analysis, hereby I try to figure out what's the relation between number of checkins and tips people leave.

The live application is available here:

[Regression](https://soobrosa.shinyapps.io/data_products)

Data Source
========================================================

The application calls the Explore Recommended and Popular Venues API endpoint of Foursquare and extracts the data points for the 30 most interesting venues.

[API URL](https://developer.foursquare.com/docs/venues/explore)
***
![Example of Foursquare API call](http://i.stack.imgur.com/MeO7I.png)

Reactive Plotting
========================================================

I use the plotrix library to be able to analyse and understand possible linear models.


```r
library(plotrix)

y <- runif(10)
err <- runif(10)
plotCI(1:10, y, err, main = "Basic plotCI")
```

<img src="data_products-figure/unnamed-chunk-1-1.png" title="plot of chunk unnamed-chunk-1" alt="plot of chunk unnamed-chunk-1" width="300px" />

Further Steps
========================================================

Exploring all possible quantified attributes could easily lead to a simple model to better understand Foursquare recommendations.
