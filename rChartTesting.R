library(rCharts)
library(lattice)
library(plotly)

df_countries <- data.frame(country = c("DE", "FR", "GB", "US", "IT", "AU", "CA"), 
                           items = c(25000, 17500, 23000, 98000, 17000, 6250, 12900))

p_country_item <- rPlot(items ~ country, data = df_countries, color = "country", type = "bar")
p_country_item$print("Items per Country")


df_countries <- cbind(df_countries,
                      given = c(9000, 6000, 12000, 45000, 2000, 1000, 9000),
                      last = c(4000, 2000, 9000, 12000, 978, 45, 2210),
                      title = c(500, 100, 20, 400, 100, 27, 48))


# using lattice
p_lattice <- barchart(given + last + title ~ country, data = df_countries)
plot(p_lattice)

# trying rCharts, works
p_countries <- mPlot(x = "country", y = list("items", "given", "last", "title"), data = df_countries, type = "Bar")
p_countries$save("graphics/p_countries.html", cdn = TRUE)
p_countries


# let's try a map with plotly, doesn't work, not sure plotly helps us...
p_countries_plotly <- plot_ly(data = df_countries, x = "country", y = list("items", "given", "last", "title"), type = "bar")
p_countries_plotly

# and now some googlevis
library(googleVis)
bar1 <- gvisBarChart(df_countries, xvar = "country", yvar = c("items", "given"))
plot(bar1)

bar2 <- gvisBarChart(df_countries, yvar = c("given", "last", "title"), xvar = "country", options = list(isStacked = TRUE))
plot(bar2)

geo1 <- gvisGeoChart(df_countries, locationvar = "country", sizevar = "items")
plot(geo1)

# and now let's stick all into a slidify presentation


