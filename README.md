# Open Street Map

MoveApps

Github repository: *github.com/movestore/Open-Street-Map*

## Description
Plot your tracks as lines on a background downloaded from OpenStreetMaps. The output is a Shiny UI with variable map extent.

## Documentation
This App downloads a map from OpenStreetMaps according to the extent of your data (+ some border region as determined by the user variable "Define edge size to view coastlines").

### Input data
moveStack in Movebank format

### Output data
Shiny user interface (UI)

### Artefacts
`openstreetmap.pdf`: pdf-file of Open Street Map of your data with initial border settings.

### Parameters 
`Define edge size to view coastlines`: The amount of longitude and latitude units that shall be added at the edges of the data's bounding box for better visibility. Default 1 degree.

### Null or error handling:

**Parameter `Define edge size to view coastlines`:** The default value is `1`, which leads to a margin of 1 degree in latitude and longitude direction on the map around the locations' bounding box.

**Data:** The data are not manipulated, but empty input with no locations (NULL) leads to an error. For calculations in further Apps the input data set is returned.

