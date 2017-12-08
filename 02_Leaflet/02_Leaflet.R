setwd('~/take-home-final/02_Leaflet')

# Libraries
library(leaflet)

# Read data
SA <- read.csv('south_amer.csv', header=T)

# Pop-up text
popup_dat <- paste0("<strong>City: </strong>", 
                    SA$city,
                    "<br><strong>Year: </strong>", 
                    SA$iyear, 
                    "<br><strong>Number Killed: </strong>", 
                    SA$nkill)


# Leaflet Map
map <- leaflet(SA) %>% 
  addProviderTiles(providers$CartoDB.Positron) %>% 
  addTiles() %>% 
  addMarkers(clusterOptions = markerClusterOptions(), popup = popup_dat)

map
saveWidget(map, '02_leaflet.html', selfcontained = TRUE)



