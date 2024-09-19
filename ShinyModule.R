library('move2')
library('ggspatial')
library("ggplot2")
library('shiny')
library("randomcoloR")
library("shinycssloaders")
library("scales")
library("shinyBS")

## choose a better color selection?....

# rosm::osm.types()
# [1] "osm" "hotstyle"   "cartodark" "cartolight"   
# api req  "opencycle" "osmtransport" "thunderforestlandscape" "thunderforestoutdoors"
# not very inform "loviniahike"  "loviniacycle"  
# problems "stamenbw" "stamenwatercolor"

shinyModuleUserInterface <- function(id, label) {
  ns <- NS(id)
  fluidPage(
    titlePanel("Open Street Map"),
    sidebarLayout(
      sidebarPanel(
        checkboxInput(ns("legend"), label = "Show legend with track names", value = FALSE),
        radioButtons(ns("maptype"),label = "Background map types",
                     choices = list("OSM" = "osm", "Humanitarian" = "hotstyle", "Carto Dark" = "cartodark", "Carto Light" = "cartolight"),
                     selected = "osm" ),
        bsTooltip(id=ns("maptype"), title="Inspect the different map types at a low resolution as it is faster", placement = "bottom", trigger = "hover", options = list(container = "body")),
        
        radioButtons(ns("zoomin"),label = "Resolution of background map",
                     choices = list("very low" = -2, "low" = -1, "high" = 0, "very high" = 1),
                     selected = -2 )#,
        # bsTooltip(id=ns("zoomin"), title="Chosing a very high resolution for data covering a large area might lead the App to crash", placement = "bottom", trigger = "hover", options = list(container = "body"))
      ,width = 2),
      mainPanel(
        withSpinner(plotOutput(ns("map"),height="80vh"))
      , width = 10)
    )
  )
}


shinyModule <- function(input, output, session, data) {
  current <- reactiveVal(data)
  
  output$map <- renderPlot({
    n <- length(unique(mt_track_id(data)))
    if(n < 10){colspt <- brewer_pal(palette = "Set1")(n)}else{colspt <- distinctColorPalette(n)}
    id_col <- sym(mt_track_id_column(data))
    osmap <- ggplot() +
      ggspatial::annotation_map_tile(zoomin = as.numeric(input$zoomin), type=input$maptype) +
      ggspatial::annotation_scale(aes(location="br")) +
      theme_linedraw() +
      geom_sf(data = mt_track_lines(data),  aes(color = !!id_col)) +
      geom_sf(data = data, aes(color = !!id_col), size = 1)
    
    if(!input$legend){
      mp <- osmap +guides(color = "none")
      
    }
    if(input$legend){
      mp <- osmap + scale_color_manual("Tracks",values=colspt)
    }
    
    ggsave(mp, file = appArtifactPath("openstreetmap.pdf"))
    mp
  })
  
  return(reactive({ current() }))
}

