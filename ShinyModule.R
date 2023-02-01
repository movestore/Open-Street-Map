library('move')
library('ggmap')
library('shiny')
library("randomcoloR")
library("shinycssloaders")
library("scales")

## choose a better color selection?....

shinyModuleUserInterface <- function(id, label) {
  ns <- NS(id)
  
  tagList(
    titlePanel("Open Street map"),
    numericInput(ns("num"), "Define edge size to view coastlines (in degrees of lon/lat):", value=1, min = 0, max = 90,step=0.00001),
    withSpinner(plotOutput(ns("map"),height="80vh"))
  )
}


shinyModule <- function(input, output, session, data) {
  current <- reactiveVal(data)
  
  output$map <- renderPlot({
    mDF <- data.frame(long=coordinates(data)[,1],lat=coordinates(data)[,2], indiv=trackId(data))
    n <- length(unique(mDF$indiv))
    if(n < 10){colspt <- brewer_pal(palette = "Set1")(n)}else{colspt <- distinctColorPalette(n)}
    
    map <- get_map(bbox(extent(data)+c(-input$num,input$num,-input$num,input$num)),source="stamen") #,source="osm")
    osmap <- ggmap(map) +
      geom_path(data=mDF,aes(x=long,y=lat,group=indiv,colour=indiv)) +
      geom_point(data=mDF,aes(x=long,y=lat,colour=indiv),size=3)+
      scale_color_manual("Individuals",values=colspt)
    ggsave(osmap, file = appArtifactPath("openstreetmap.pdf"))
    osmap
  })
  
  return(reactive({ current() }))
}

