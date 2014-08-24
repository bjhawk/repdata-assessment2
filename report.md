Impact of Hydro-Meteorological Events, US 1950-2011
===================================================

###Synopsis:  
    The impact of a storm can range from insignificant to immense. In this document
    we attempt to take a cursory glance through what might be the most impactful
    storm types according to all the data the NOAA has to offer from 1950 through 2011.
  

##Data Processing:
	To begin with, our data comes in the form of a rather large Comma Separated Value file.
	Roughly half a gigabyte, this file contains just over 900 thousand observation,
  spaning just over 60 years. The data for the last 20 or 30 years is considerably,
  and understandably,	more complete.  

	To begin with we will need to take the data from it's raw text form and bring it into R
	to start our analysis. We will be using the `data.table` package to make our processing
  faster after our initial read.  
  You'll note I'm using the `base` packages' `read.csv()` function and then immediately
  turning that `data.frame` into a `data.table`. This is because there is a known and
  tracked bug when using `fread` to read .csv files that have irregular usage of commas
  inside escaped blocks of text. That being said, the method below only takes a fractional
  amount of time more and will yeild considerably faster processing below:  

```r
library(data.table)
data <- data.table(read.csv('stormdata.csv'))
```
