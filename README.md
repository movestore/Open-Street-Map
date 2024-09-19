# Open Street Map

MoveApps

Github repository: *github.com/movestore/Open-Street-Map*

## Description
Plot your tracks as lines on a background map downloaded from OpenStreetMaps. The output is a Shiny UI with variable map resolutions and map types.

## Documentation
This App downloads a map from OpenStreetMaps according to the extent of your data by default at the lowest resolution. The resolution can be changed. Different map types can be selected. For a first inspection of the different map types, we recommend to use a low resolution as it will be much faster. The names of the tracks can be hidden or shown in a legend.


### Application scope
#### Generality of App usability
This App was developed for any taxonomic group. 

#### Required data properties
The App should work for any kind of (location) data.

### Input type
`move2::move2_loc`

### Output type
`move2::move2_loc`

### Artefacts
`openstreetmap.pdf`: pdf-file of the Open Street Map with your tracks and the chosen settings.

### Settings 
`Show legend with track names`: choose if to show the track names as a legend or not. By default legend is not shown.

`Background map types`: choose a map type, options are "OSM", "Humanitarian", "Carto Dark", "Carto Light". Deafult "OSM".

`Resolution of background map`: choose the resolution of the map. Options are "very low", "low", "high" and "very high". Defalt is "very low".

`Store settings`: click to store the current settings of the App for future Workflow runs. 

### Changes in output data
The input data remains unchanged.

### Most common errors


### Null or error handling

