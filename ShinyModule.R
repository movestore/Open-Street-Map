library('move')
library('ggmap')
library('shiny')

shinyModuleUserInterface <- function(id, label, num, col) {
  ns <- NS(id)

  tagList(
    titlePanel("Open Street map"),
    numericInput(ns("num"), "Define edge size to view coastlines (in degrees of lon/lat):", num, min = 0, max = 90,step=0.00001),
    verbatimTextOutput("value1"),
    plotOutput(ns("map"),height="90vh")
  )
}

shinyModuleConfiguration <- function(id, input) {
  ns <- NS(id)
  
  configuration <- list()
  
  configuration
}

shinyModule <- function(input, output, session, data, col, num) {
  current <- reactiveVal(data)

  map1 <- get_map(bbox(extent(data)+c(-num,num,-num,num)))
  pdfmap <- ggmap(map1) +
    geom_path(data=as.data.frame(data),aes(x=location_long,y=location_lat,group=local_identifier),colour=col) +
    geom_point(data=as.data.frame(data),aes(x=location_long,y=location_lat),colour=col,size=3)
    
  ggsave(pdfmap, file = paste0(Sys.getenv(x = "APP_ARTIFACTS_DIR", "/tmp/"),"openstreetmap.pdf"))
  
  osmap <- reactive({
    map <- get_map(bbox(extent(data)+c(-input$num,input$num,-input$num,input$num)))
  
    out <- ggmap(map) +
      geom_path(data=as.data.frame(data),aes(x=location_long,y=location_lat,group=local_identifier),colour=col) +
      geom_point(data=as.data.frame(data),aes(x=location_long,y=location_lat),colour=col,size=3)
    out
    })

  output$map <- renderPlot({
    osmap()
  })
  
  return(reactive({ current() }))
}

