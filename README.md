# Open Street Map

MoveApps

Github repository: *github.com/movestore/Open-Street-Map*

## Description
Plot your tracks as lines on a background downloaded from OpenStreetMaps. The output is a Shiny UI with variable map extent.

## Documentation
This App downloads a map from OpenStreetMaps according to the extent of your data (+ some border region as determined by the user variable "num"). On this map your movement tracks are plotted as lines in the colour that you can specify.

### Input data
moveStack in Movebank format

### Output data
Shiny user interface (UI)

### Artefacts
no artefacts

### Parameters 
`num`: The amount of longitude and latitude units that shall be added at the edges of the data's bounding box for better visibility.

`col`: Colour name that defines the colouring of your data tracks on the map. Default is "red". See https://www.r-graph-gallery.com/42-colors-names.html for a selection of name options or type `colors()` into an R console for the complete list of available colour names.


### Null or error handling:

**Parameter `num`:** The default value is `1`, which leads to a margin of 1 degree in latitude and longiture direction on the map around the locations' bounding box.

**Parameter `col`:** The default value is "red". If values are entered that are not on the R list an error will be shown in the UI and App Logs. Please go back to your settings and correct it.

**Data:** The data are not manipulated, but empty input with no locations (NULL) leads to an error. For calculations in further Apps the input data set is returned.

