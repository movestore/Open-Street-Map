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
    sliderInput(inputId = ns("zoom"), 
                label = "Resolution of background map", 
                value = 5, min = 3, max = 18, step=1),
    textInput(ns("api"), "Enter your stadia API key. (This is required until MoveApps provides its OSM mirror. Register with stamen, it is free: https://stadiamaps.com/stamen/onboarding/create-account", value = ""),
    withSpinner(plotOutput(ns("map"),height="80vh"))
  )
}


shinyModule <- function(input, output, session, data) {
  current <- reactiveVal(data)
  
  output$map <- renderPlot({
    mDF <- data.frame(long=coordinates(data)[,1],lat=coordinates(data)[,2], indiv=trackId(data))
    n <- length(unique(mDF$indiv))
    if(n < 10){colspt <- brewer_pal(palette = "Set1")(n)}else{colspt <- distinctColorPalette(n)}
    
    if(input$api=="") logger.info("no API key entered") else register_stadiamaps(input$api)
    
    map <- get_stadiamap(bbox(extent(data)+c(-input$num,input$num,-input$num,input$num)),source="stamen_terrain",zoom=input$zoom)
    osmap <- ggmap(map) +
      geom_path(data=mDF,aes(x=long,y=lat,group=indiv,colour=indiv)) +
      geom_point(data=mDF,aes(x=long,y=lat,colour=indiv),size=3)+
      scale_color_manual("Individuals",values=colspt)
    ggsave(osmap, file = appArtifactPath("openstreetmap.pdf"))
    osmap
  })
  
  return(reactive({ current() }))
}

